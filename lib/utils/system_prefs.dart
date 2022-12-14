import 'package:shared_preferences/shared_preferences.dart';

class SystemPrefs {
  SystemPrefs();

  static const String authToken = "CISI_TOKEN";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getAuthToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(authToken) ?? "";
  }

  Future<void> setAuthToken(String token) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString(authToken, token);
  }

  Future<void> clearAuthToken() async {
    SharedPreferences prefs = await _prefs;
    prefs.remove(authToken);
  }

}