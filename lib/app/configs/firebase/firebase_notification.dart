import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:e_penting/app/configs/local_notification/local_notification.dart';

class FirebaseNotification {
  new(this._localNotification);

  final LocalNotification _localNotification;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    try {
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            carPlay: true,
            criticalAlert: true,
            provisional: true,
            sound: true,
          );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        if (kDebugMode) print('Denied Notification Permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        if (kDebugMode) print('Provosional Notification Permission');
      } else {
        if (kDebugMode) print('Authorized Notification Permission');
      }
    } catch (e) {
      if (kDebugMode) print('Gagal meminta izin notifikasi: $e');
    }
  }

  Future<void> init() async {
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      FirebaseMessaging.onMessage.listen((message) {
        if (kDebugMode) print('FOREGROUND FIREBASE NOTIF : $message');
        if (kDebugMode) print('DATA : ${message.data}');
        if (kDebugMode) print('DATA DATA : ${message.data['data']}');

        if (message.notification != null) {
          _localNotification.showNotifications(
            id: message.notification.hashCode,
            title: message.notification?.title,
            body: message.notification?.body,
            payload: message.data.toString(),
            imageUrl: message.notification?.android?.imageUrl,
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((
        RemoteMessage message,
      ) async {
        if (kDebugMode) print(message.notification?.title);
        if (kDebugMode) print(message.notification?.body);
        if (kDebugMode) print(message.notification?.android?.imageUrl);
        if (kDebugMode) print(message.notification?.apple?.imageUrl);
        if (kDebugMode) print(message.data);
      });

      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();

      if (initialMessage != null) {
        if (kDebugMode) {
          print('APP OPEN FROM NOTIFICATION WHEN APP TERMINATED');
          print(initialMessage.notification?.title);
          print(initialMessage.notification?.body);
          print(initialMessage.notification?.android?.imageUrl);
          print(initialMessage.data);
        }
      }
    } catch (e) {
      if (kDebugMode) print('Gagal inisialisasi Firebase Messaging: $e');
    }
  }

  Future<String?> _getApnsToken() async {
    try {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();

      if (apnsToken != null) return apnsToken;

      await Future<void>.delayed(const Duration(seconds: 3));

      apnsToken = await _firebaseMessaging.getAPNSToken();

      if (apnsToken == null) {
        if (kDebugMode) {
          print('APNs Token tidak ditemukan. Push Notif iOS akan gagal.');
        }
      }

      return apnsToken;
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      if (Platform.isIOS) {
        final apnsToken = await _getApnsToken();

        if (apnsToken == null) {
          if (kDebugMode) print('APNs token kosong');

          return null;
        }
      }

      return await _firebaseMessaging.getToken();
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  void isTokenRefresh() async {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }
}
