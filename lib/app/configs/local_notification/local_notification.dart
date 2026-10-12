import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode, Uint8List;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class _NotificationImage {
  _NotificationImage._();
  static final Dio _downloadDio =
      Dio(
          BaseOptions(
            responseType: .bytes,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
          ),
        )
        ..interceptors.addAll([
          if (kDebugMode) ...{
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: false,
              responseHeader: false,
              error: true,
              compact: true,
              maxWidth: 90,
            ),
          },
        ]);

  static Future<Uint8List?> downloadImage(String imageUrl) async {
    try {
      final response = await _downloadDio.get<List<int>>(imageUrl);

      if (response.data == null || (response.data?.isEmpty ?? false)) {
        return null;
      }

      return Uint8List.fromList(response.data!);
    } catch (e) {
      if (kDebugMode) {
        if (kDebugMode) print('Gagal mengunduh gambar notifikasi: $e');
      }

      return null;
    }
  }

  static Future<String?> saveImage(Uint8List? imageBytes) async {
    if (imageBytes == null || imageBytes.isEmpty) return null;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          'notification_img_${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);

      return filePath;
    } catch (e) {
      if (kDebugMode) print('Gagal menyimpan file gambar notifikasi: $e');

      return null;
    }
  }
}

class LocalNotification {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    try {
      const AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings('@mipmap/ic_notification');

      const DarwinInitializationSettings darwinInitializationSettings =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            requestProvisionalPermission: false,
            requestCriticalPermission: false,
          );

      const InitializationSettings initializationSettings =
          InitializationSettings(
            android: androidInitializationSettings,
            iOS: darwinInitializationSettings,
          );

      const AndroidNotificationChannel androidNotificationChannel =
          AndroidNotificationChannel(
            'notifikasi_umum',
            'Notifikasi Umum',
            importance: Importance.max,
            enableLights: true,
            enableVibration: true,
            playSound: true,
            showBadge: true,
          );

      await _flutterLocalNotificationsPlugin.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: (details) async {
          final payload = details.payload;

          if (payload != null) {
            if (kDebugMode) print('FOREGROUND PAYLOAD LOCAL NOTIF : $payload');
          }
        },
      );

      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(androidNotificationChannel);
    } catch (e) {
      if (kDebugMode) print('Gagal inisialisasi Local Notification: $e');
    }
  }

  Future<void> showNotifications({
    required int id,
    String? title,
    String? body,
    dynamic payload,
    String? imageUrl,
  }) async {
    String? savedImagePath;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final imageBytes = await _NotificationImage.downloadImage(imageUrl);
      savedImagePath = await _NotificationImage.saveImage(imageBytes);
    }

    try {
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'notifikasi_umum',
            'Notifikasi Umum',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            fullScreenIntent: false,
            enableLights: true,
            enableVibration: true,
            playSound: true,
            channelShowBadge: true,
            largeIcon: savedImagePath == null
                ? null
                : FilePathAndroidBitmap(savedImagePath),
            styleInformation: savedImagePath == null
                ? null
                : BigPictureStyleInformation(
                    FilePathAndroidBitmap(savedImagePath),
                    contentTitle: title,
                    summaryText: body,
                    hideExpandedLargeIcon: true,
                  ),
          );

      DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            attachments: savedImagePath == null
                ? null
                : [DarwinNotificationAttachment(savedImagePath)],
          );

      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails,
      );

      await _flutterLocalNotificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: platformChannelSpecifics,
        payload: payload,
      );
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
}
