import 'package:envied/envied.dart';

part 'enviroment_variables.g.dart';

@Envied(path: ".env", obfuscate: true)
class EnviromentVariables {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static final String apiUrl = _EnviromentVariables.apiUrl;
}
