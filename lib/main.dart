import 'package:epenting/app/configs/firebase/firebase_notif.dart';
import 'package:epenting/app/configs/firebase/firebase_options.dart';
import 'package:epenting/app/configs/local_notification/local_notif.dart';
import 'package:epenting/app/configs/router/app_router.dart';
import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/views/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:epenting/app/configs/get_it/service_locator.dart' as di;
import 'package:lottie/lottie.dart';

Future<void> loadDotEnv() async {
  try {
    await dotenv.load(fileName: AppStrings.env);
  } catch (e) {
    if (kDebugMode) print(e);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) print('BACKGROUND FIREBASE NOTIF : $message');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadDotEnv();
  di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseNotif firebaseNotif = FirebaseNotif();
  LocalNotif localNotif = LocalNotif();

  await firebaseNotif.requestNotificationPermission();
  firebaseNotif.firebaseInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await localNotif.init();

  initializeDateFormatting('id_ID');
  Intl.defaultLocale = 'id_ID';

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AuthCubit>(),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return GlobalLoaderOverlay(
            overlayColor: Colors.black.withValues(alpha: 0.4),
            disableBackButton: true,
            overlayWholeScreen: true,
            overlayHeight: ScreenUtil().screenHeight,
            overlayWidth: ScreenUtil().screenWidth,
            overlayWidgetBuilder: (progress) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Lottie.asset(
                    '${AppStrings.assetsLotties}/loader.json',
                    width: 80.w,
                    frameRate: const FrameRate(144),
                  ),
                ),
              );
            },
            child: MaterialApp(
              title: 'E-Penting',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.scaffoldBgColor,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.orangeColor,
                ),
                fontFamily: 'Poppins',
                useMaterial3: true,
                applyElevationOverlayColor: false,
              ),
              initialRoute: SplashPage.routeName,
              onGenerateRoute:
                  (settings) => AppRouter.onGenerateRoute(context, settings),
            ),
          );
        },
      ),
    );
  }
}
