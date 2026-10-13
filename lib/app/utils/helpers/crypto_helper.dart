import 'package:encrypt/encrypt.dart' as encrypt;

class CryptoHelper {
  static String generateMasterKey() {
    final secureRandom = encrypt.SecureRandom(32);
    return secureRandom.base64;
  }

  static String encryptData(String rawData, String base64MasterKey) {
    final key = encrypt.Key.fromBase64(base64MasterKey);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(rawData, iv: iv);

    return '${iv.base64}:${encrypted.base64}';
  }

  static String decryptData(String encryptedData, String base64MasterKey) {
    final parts = encryptedData.split(':');
    final iv = encrypt.IV.fromBase64(parts[0]);
    final cipherText = parts[1];

    final key = encrypt.Key.fromBase64(base64MasterKey);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    return encrypter.decrypt64(cipherText, iv: iv);
  }
}
