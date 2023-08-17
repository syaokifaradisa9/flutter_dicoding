import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:story_app/config/values.dart';
import 'package:story_app/services/local_storage_service.dart';

class AuthService{
  LocalStorageService localStorageService;
  AuthService({required this.localStorageService});

  Future<bool> login({required String email, required String password}) async{
    try{
      final http.Response response = await  http.post(
        Uri.parse("$baseApiUrl/login"),
        body: {
          "email": email,
          "password": password
        }
      );

      var json = jsonDecode(response.body);
      bool isLoginSuccess = !json['error'];
      if(isLoginSuccess){
        String token = json['loginResult']['token'];
        await localStorageService.saveUserToken(token: token);
        await localStorageService.saveLoginState(status: true);
        return true;
      }else{
        return Future.error(json['message']);
      }
    }catch(e){
      return Future.error(e.toString());
    }
  }

  Future<bool> register({
    required String name, required String email, required String password
  }) async{
    try{
      final http.Response response = await http.post(
          Uri.parse("$baseApiUrl/register"),
          body: {
            "name": name,
            "email": email,
            "password": password
          }
      );

      var json = jsonDecode(response.body);
      bool isSuccess = !jsonDecode(response.body)['error'];
      if(isSuccess){
        return isSuccess;
      }else{
        return Future.error(json['message']);
      }
    }catch(e){
      return Future.error(e.toString());
    }
  }
}