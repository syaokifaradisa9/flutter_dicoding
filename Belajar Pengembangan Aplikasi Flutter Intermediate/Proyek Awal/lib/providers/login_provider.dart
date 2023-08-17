import 'package:flutter/material.dart';
import 'package:story_app/config/alert.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/services/auth_service.dart';

class LoginProvider with ChangeNotifier{
  final AuthService authService;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool isLoading = false;
  bool isFormValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  LoginProvider({required this.authService}){
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void onChangeEmailForm(dynamic value){
    isEmailValid = value.toString().isNotEmpty;
    isFormValid = isEmailValid && isPasswordValid;
    notifyListeners();
  }

  void onChangePasswordForm(dynamic value){
    isPasswordValid = value.toString().isNotEmpty;
    isFormValid = isEmailValid && isPasswordValid;
    notifyListeners();
  }

  Future<bool> login({ required BuildContext context }) async{
    try{
      if(isFormValid){
        isLoading = true;
        notifyListeners();

        await authService.login(
            email: emailController.text,
            password: passwordController.text
        );

        isLoading = false;
        notifyListeners();

        clear();
        return true;
      }else{
        return false;
      }
    }catch(e){
      isLoading = false;
      notifyListeners();

      if(e.toString().contains("User not found")){
        showSnackBar(
          context: context,
          text: AppLocalizations.of(context)!.userNotFoundErrorText,
          backgroundColor: errorColor,
        );
      }

      if(e.toString().contains("Invalid password")){
        showSnackBar(
          context: context,
          text: AppLocalizations.of(context)!.invalidPasswordErrorText,
          backgroundColor: errorColor,
        );
      }

      if(e.toString().contains("password is at least 8 characters")){
        showSnackBar(
          context: context,
          text: AppLocalizations.of(context)!.passwordValidationErrorText,
          backgroundColor: errorColor,
        );
      }

      return false;
    }
  }

  void clear(){
    emailController.clear();
    passwordController.clear();
    isFormValid = false;
    isEmailValid = false;
    isPasswordValid = false;
  }
}