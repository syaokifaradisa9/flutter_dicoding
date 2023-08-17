part of 'providers.dart';

class ResetPasswordProvider with ChangeNotifier{
  String? email;
  bool? isFormValid;

  void reset(){
    isFormValid = false;
    email = "";
  }

  void checkEmail(dynamic value){
    email = value;
    if(email!.isNotEmpty){
      isFormValid = true;
    }else{
      isFormValid = false;
    }

    notifyListeners();
  }
}