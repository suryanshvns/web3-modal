import 'package:web3_modal_integration/shared_preference/shared_preference_db.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const String buildMode =
      String.fromEnvironment('BUILD_MODE', defaultValue: 'DEBUG');
  static String getSubdomain(String prodSubdomain) {
    switch (buildMode) {
      case 'RELEASE':
        return prodSubdomain;
      case 'QA':
        return '$prodSubdomain.qa';
      case 'DEBUG':
      default:
        return '$prodSubdomain.dev';
    }
  }

  static const String _protocol = 'https://';
  static final String gqlMainEndPoint =
      '$_protocol${getSubdomain('api-v2-mumbai-live.lens')}/';
  static Map<String, String> authHeaders() =>
      <String, String>{'Authorization': 'Bearer ${PrefsDb.getToken}'};
}
