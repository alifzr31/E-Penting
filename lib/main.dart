import 'package:e_penting/app/configs/firebase/firebase_notification.dart';
import 'package:e_penting/app/configs/firebase/firebase_options.dart';
import 'package:e_penting/app/configs/get_it/service_locator.dart' as di;
import 'package:e_penting/app/configs/local_notification/local_notification.dart';
import 'package:e_penting/app/configs/router/app_router.dart';
import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final LocalNotification localNotification = LocalNotification();

    await localNotification.showNotifications(
      id: message.notification.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      payload: message.data.toString(),
      imageUrl: message.notification?.android?.imageUrl,
    );

    if (kDebugMode) print('BACKGROUND FIREBASE NOTIF : $message');
  } catch (e) {
    if (kDebugMode) print('Gagal menampilkan notifikasi di background: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  di.setupServiceLocator(sharedPreferences);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseNotification = di.sl<FirebaseNotification>();
  final localNotification = di.sl<LocalNotification>();

  await firebaseNotification.requestNotificationPermission();
  await firebaseNotification.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await localNotification.init();

  // BASE API URL REMOTE CONFIG
  // final firebaseRemote = di.sl<FirebaseRemote>();
  // await firebaseRemote.init();

  initializeDateFormatting(AppStrings.indonesianLocale);
  Intl.defaultLocale = AppStrings.indonesianLocale;

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di.sl<PackageInfoCubit>()),
        BlocProvider.value(value: di.sl<AuthCubit>()),
      ],
      child: GlobalLoaderOverlay(
        overlayColor: Colors.black.withValues(alpha: 0.4),
        disableBackButton: true,
        overlayWholeScreen: true,
        overlayHeight: context.deviceHeight,
        overlayWidth: context.deviceWidth,
        overlayWidgetBuilder: (progress) {
          return Center(
            child: Container(
              padding: const .all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: .circle,
              ),
              child: Lottie.asset(
                '${AppStrings.assetsLotties}/loader.json',
                width: 70,
              ),
            ),
          );
        },
        child: MaterialApp(
          title: 'E-Penting',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orangeColor),
            appBarTheme: const AppBarTheme(
              titleSpacing: 0,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              actionsPadding: .symmetric(horizontal: 16),
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: .w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            scaffoldBackgroundColor: AppColors.scaffoldBgColor,
            fontFamily: 'Poppins',
            useMaterial3: true,
            applyElevationOverlayColor: false,
          ),
          initialRoute: RouteName.splash,
          onGenerateRoute: di.sl<AppRouter>().onGenerateRoute,
          // home: const TestPage(),
        ),
      ),
    );
  }
}
