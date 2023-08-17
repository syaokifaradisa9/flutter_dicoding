part of 'providers.dart';

class RegisterProvider with ChangeNotifier{
  bool isFormValid = false;
  bool isConfirmationPasswordValid = false;

  String? name;
  String? email;
  String? password;
  String? confirmationPassword;

  void reset(){
    isFormValid = false;
    isConfirmationPasswordValid = false;
    name = "";
    email = "";
    password = "";
    confirmationPassword = "";
  }

  void checkName(dynamic value){
    name = value;
    _checkFormValidation();
  }

  void checkEmail(dynamic value){
    email = value;
    _checkFormValidation();
  }

  void checkPassword(dynamic value){
    password = value;
    _checkFormValidation();
  }

  void checkConfirmationPassword(dynamic value){
    confirmationPassword = value;
    if(password == confirmationPassword){
      isConfirmationPasswordValid = true;
    }else{
      isConfirmationPasswordValid = false;
    }

    _checkFormValidation();
  }

  void _checkFormValidation(){
    if(name!.isNotEmpty && password!.isNotEmpty && (password == confirmationPassword)){
      isFormValid = true;
    }else{
      isFormValid = false;
    }

    notifyListeners();
  }
}