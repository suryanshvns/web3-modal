import 'package:hive/hive.dart';

class PrefsBoxKeys {
  static const token = 'token';
  static const profileId = 'profileId';
  static const challengeId = 'challengeId';
  static const signatureId = 'signatureId';
  static const msg = 'msg';
  static const id = 'id';
}

class PrefsDb {
  static var prefsBox = Hive.box('prefs');
  static Box get box => prefsBox;

  static String? get getToken => prefsBox.get(PrefsBoxKeys.token);
  static void saveToken(String? token) =>
      prefsBox.put(PrefsBoxKeys.token, token.toString());

  static String? get getProfileId => prefsBox.get(PrefsBoxKeys.profileId);
  static void saveProfileId(String? profileId) =>
      prefsBox.put(PrefsBoxKeys.profileId, profileId);

  static String? get getWalletId => prefsBox.get(PrefsBoxKeys.challengeId);
  static void saveWalletId(String? challengeId) =>
      prefsBox.put(PrefsBoxKeys.challengeId, challengeId);

  static String? get getSignatureId => prefsBox.get(PrefsBoxKeys.signatureId);
  static void saveSignatureId(String? signatureId) =>
      prefsBox.put(PrefsBoxKeys.signatureId, signatureId);

  static String? get getSignedMsg => prefsBox.get(PrefsBoxKeys.msg);
  static void saveSignedMsg(String? msg) => prefsBox.put(PrefsBoxKeys.msg, msg);

  static String? get getSignedId => prefsBox.get(PrefsBoxKeys.id);
  static void saveSignedId(String? id) => prefsBox.put(PrefsBoxKeys.id, id);
}
