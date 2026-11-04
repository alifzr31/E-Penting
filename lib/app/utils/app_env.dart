import 'package:envied/envied.dart';

part 'app_env.g.dart';

@Envied(path: '.env')
abstract class AppEnv {
  @EnviedField(varName: 'PROD_BASE_URL', obfuscate: true)
  static final String prodBaseUrl = _AppEnv.prodBaseUrl;

  @EnviedField(varName: 'PROD_BASE_API_URL', obfuscate: true)
  static final String prodBaseApiUrl = _AppEnv.prodBaseApiUrl;

  @EnviedField(varName: 'STAGGING_BASE_URL', obfuscate: true)
  static final String staggingBaseUrl = _AppEnv.staggingBaseUrl;

  @EnviedField(varName: 'STAGGING_BASE_API_URL', obfuscate: true)
  static final String staggingBaseApiUrl = _AppEnv.staggingBaseApiUrl;

  @EnviedField(varName: 'EPENTING_SIGNATURE', obfuscate: true)
  static final String ePentingSignature = _AppEnv.ePentingSignature;
}
