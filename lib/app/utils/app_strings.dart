import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {
  static const String env = '.env';
  static final String baseUrl = dotenv.get('BASE_URL');
  static final String baseApiUrl = dotenv.get('BASE_API_URL');
  static const String assetsImages = 'assets/images';
  static const String assetsLotties = 'assets/lotties';
}
