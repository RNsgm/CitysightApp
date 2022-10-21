import 'dart:convert';

import 'package:citysight_app/network/network.dart';
import 'package:citysight_app/utils/system_prefs.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

var logger = Logger();
SystemPrefs _prefs = SystemPrefs();

Future<bool> isAdmin() async {
  String token  = await _prefs.getAuthToken();
  final response = await http.post(
      Uri.parse('${Network.defaultUrl}/api/v1/user/is_admin'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': token
      },
    );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['value'];
  } else if(response.statusCode == 400) {
    return false;
  } else {
    return false;
  }
}
Future<bool> isEditor() async {
  String token  = await _prefs.getAuthToken();
  final response = await http.post(
      Uri.parse('${Network.defaultUrl}/api/v1/user/is_editor'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': token
      },
    );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['value'];
  } else if(response.statusCode == 400) {
    return false;
  } else {
    return false;
  }
}
Future<bool> isModerator() async {
  String token  = await _prefs.getAuthToken();
  final response = await http.post(
      Uri.parse('${Network.defaultUrl}/api/v1/user/is_Moderator'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': token
      },
    );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['value'];
  } else if(response.statusCode == 400) {
    return false;
  } else {
    return false;
  }
}