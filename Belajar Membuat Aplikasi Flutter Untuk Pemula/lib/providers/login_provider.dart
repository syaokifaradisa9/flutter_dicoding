part of 'providers.dart';

class LoginProvider with ChangeNotifier{
  bool isFormValid = false;
  String email = '';
  String password = '';

  void reset(){
    email = "";
    password = "";
    isFormValid = false;
  }

  void checkEmail(dynamic value){
    email = value;
    _checkFormValidation();
  }

  void checkPassword(dynamic value){
    password = value;
    _checkFormValidation();
  }

  void _checkFormValidation(){
    if(email.isNotEmpty && password.isNotEmpty){
      isFormValid = true;
    }else{
      isFormValid = false;
    }
    notifyListeners();
  }
}