import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService{
  final String stateKey = "login-state";
  final String tokenKey = "user-token";

  Future<bool> isLoggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(stateKey) ?? false;
  }

  Future<bool> saveLoginState({required bool status}) async{
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(stateKey, status);
  }

  Future<bool> saveUserToken({required String token}) async{
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(tokenKey, token);
  }

  Future<String> getUserToken() async{
    if(await isLoggedIn()){
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(tokenKey) ?? '';
    }else{
      return "";
    }
  }

  Future<bool> deleteLoginState() async{
    if(await isLoggedIn()){
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(tokenKey);
      prefs.remove(stateKey);
      return true;
    }else{
      return false;
    }
  }
}