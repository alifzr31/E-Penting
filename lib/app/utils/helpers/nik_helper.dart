import 'dart:math' show Random;

class NikHelper {
  static final Random _secureRandom = Random.secure();

  static String generateDummyNik() {
    const String prefix = '3273';

    String randomSuffix = '';

    for (int i = 0; i < 12; i++) {
      randomSuffix += _secureRandom.nextInt(10).toString();
    }

    return '$prefix$randomSuffix';
  }
}
