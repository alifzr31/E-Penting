import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class FirebaseRemote {
  const new(this._firebaseRemoteConfig);

  final FirebaseRemoteConfig _firebaseRemoteConfig;

  static const _kDefault = {
    'ssl_pinning_actived': true,
    'latest_version': '1.0.0',
    'latest_build_number': 1,
    'mandatory_update': true,
    'update_description': 'Perbaikan bugs dan optimalisasi performa aplikasi.',
    'base_api_url': 'https://e-penting.bandung.go.id/api/v1',
  };

  Future<void> init() async {
    try {
      await _firebaseRemoteConfig.setDefaults(_kDefault);

      await _firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: kDebugMode
              ? const Duration(seconds: 4)
              : const Duration(hours: 1),
        ),
      );

      await _firebaseRemoteConfig.fetchAndActivate();
    } catch (e) {
      if (kDebugMode) {
        print('RemoteConfig fetch error: $e');
      }
    }
  }

  bool get sslPinningActived =>
      _firebaseRemoteConfig.getBool('ssl_pinning_actived');
  String get latestVersion => _firebaseRemoteConfig.getString('latest_version');
  int get latestBuildNumber =>
      _firebaseRemoteConfig.getInt('latest_build_number');
  bool get mandatoryUpdate => _firebaseRemoteConfig.getBool('mandatory_update');
  String get updateDescription =>
      _firebaseRemoteConfig.getString('update_description');
  String get baseApiUrl => _firebaseRemoteConfig.getString('base_api_url');
}
