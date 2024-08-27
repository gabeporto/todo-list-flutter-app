import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_list_app/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AccessController{
  static final AccessController instance = AccessController._();

  late SharedPreferences _sharedPreferences;

  AccessController._();

  Future<bool> hasValidToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? token = _sharedPreferences.getString('token');
    if(token != null && !JwtDecoder.isExpired(token)){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {

    http.Response response = await http.post(
      Uri.parse('${appConstants['baseApiUrl']}/auth/login'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 60 // 1 hour
      })
    );
    
    if(response.statusCode == 200){
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString('token', jsonDecode(response.body)['token']);
      _sharedPreferences.setString('username', jsonDecode(response.body)['username']);
      _sharedPreferences.setInt('userId', jsonDecode(response.body)['id']);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
    return true;
  }

  void testJWT() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? token = _sharedPreferences.getString('token');

    if(token != null) {
      print(JwtDecoder.getExpirationDate(token));
      print(JwtDecoder.getRemainingTime(token));
      print(JwtDecoder.isExpired(token));
      print(JwtDecoder.getTokenTime(token));

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
    }
  }

  void refreshToken() async {

  _sharedPreferences = await SharedPreferences.getInstance();

    http.Response response = await http.post(
      Uri.parse('${appConstants['baseApiUrl']}/auth/refresh'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'refreshToken': _sharedPreferences.getString('token'),
          'expiresInMins': 60
        }
      )
    );

    print(response.body);

    if(response.statusCode == 200) {
      await _sharedPreferences.remove('token');
      await _sharedPreferences.setString('token', jsonDecode(response.body)['token']);
    }
  }
}