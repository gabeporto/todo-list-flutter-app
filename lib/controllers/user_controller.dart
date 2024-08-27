import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/constants/app_constants.dart';
import 'package:todo_list_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserController{
  static final UserController instance = UserController();
  late SharedPreferences _sharedPreferences;

  Future<User> getUserById() async{
    _sharedPreferences = await SharedPreferences.getInstance();

    http.Response response = await http.get(
      Uri.parse('${appConstants['baseApiUrl']}/users/${_sharedPreferences.getInt('userId')}'),
      headers: <String, String>{
      'Authorization': 'Bearer ${_sharedPreferences.getString('token')}',
      'Content-Type': 'application/json'
      } 
    );

    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Falha ao buscar usuário!');
    }
  }

  Future<User> getUserByIdFromJwtToken() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    String? token = _sharedPreferences.getString('token');

    if(token != null){
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
      return User.fromJson(decodedToken);
    }else{
      throw Exception('Token de usuário não existe!');
    }
  }

}