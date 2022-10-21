import 'dart:convert';

import 'package:citysight_app/network/network.dart';
import 'package:citysight_app/utils/system_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


class Content{
  var logger = Logger();
  SystemPrefs _prefs = SystemPrefs();

  Future<Map<String, dynamic>> feeds() async {
    String token  = await _prefs.getAuthToken();
    final response = await http.post(
        Uri.parse('${Network.defaultUrl}/api/v1/content/feeds'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': token
        },
      );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else if(response.statusCode == 400) {
      return {};
    } else {
      return {};
    }
  } 

  Future<Map<String, dynamic>> getContentById(int id) async {
    String token  = await _prefs.getAuthToken();
    final response = await http.post(
        Uri.parse('${Network.defaultUrl}/api/v1/content/get/$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': token
        },
      );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else if(response.statusCode == 400) {
      return {};
    } else {
      return {};
    }
  } 

  Future<Map<String, dynamic>> isFavorited(int id) async {
    String token  = await _prefs.getAuthToken();
    final response = await http.post(
        Uri.parse('${Network.defaultUrl}/api/v1/content/is_liked/$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': token
        },
      );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else if(response.statusCode == 400) {
      return {};
    } else {
      return {};
    }
  } 
  Future<IsLikedMeta> setFavoritedState(int id) async {
    String token  = await _prefs.getAuthToken();
    final response = await http.post(
        Uri.parse('${Network.defaultUrl}/api/v1/content/like/$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': token
        },
      );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return IsLikedMeta.fromJson(jsonDecode(response.body));
    } else if(response.statusCode == 400) {
      return IsLikedMeta(isLiked: false, count: 0);
    } else {
      return IsLikedMeta(isLiked: false, count: 0);
    }
  } 

}
class IsLikedMeta{
  IsLikedMeta({required this.isLiked, required this.count});
  bool isLiked;
  int count;

  factory IsLikedMeta.fromJson(Map<String, dynamic> json){
    return IsLikedMeta(
      isLiked: json['liked'],
      count: json['count']
    );
  }
}