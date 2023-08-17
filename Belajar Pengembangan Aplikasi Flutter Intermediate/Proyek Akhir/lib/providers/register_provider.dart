import 'package:flutter/material.dart';
import 'package:story_app/config/alert.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/services/auth_service.dart';

class RegisterProvider with ChangeNotifier{
  final AuthService authService;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  bool isFormValid = false;
  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  bool isLoading = false;

  RegisterProvider({required this.authService}){
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void onChangeNameForm(dynamic value){
    isNameValid = value.toString().isNotEmpty;
    _checkFormValidation();
  }

  void onChangeEmailForm(dynamic value){
    isEmailValid = value.toString().isNotEmpty;
    _checkFormValidation();
  }

  void onChangePasswordForm(dynamic value){
    isPasswordValid = value.toString().isNotEmpty && value.toString().length>=8;
    _checkFormValidation();
  }

  void onChangeConfirmPasswordForm(dynamic value){
    isConfirmPasswordValid = value.toString() == passwordController.text;
    _checkFormValidation();
  }

  void _checkFormValidation(){
    isFormValid = isEmailValid && isNameValid &&
                  isPasswordValid && isConfirmPasswordValid;

    notifyListeners();
  }

  Future<bool> register({required BuildContext context}) async {
    try{
      if(nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty){
        showSnackBar(
            context: context,
            text: AppLocalizations.of(context)!.formRegisterValidationErrorText,
            backgroundColor: errorColor
        );
        return false;
      }

      if(!isConfirmPasswordValid){
        showSnackBar(
          context: context,
          text: AppLocalizations.of(context)!.confirmPasswordValidationErrorText,
          backgroundColor: errorColor
        );
        return false;
      }

      if(!isPasswordValid){
        showSnackBar(
          context: context,
          text: AppLocalizations.of(context)!.passwordValidationErrorText,
          backgroundColor: errorColor
        );
        return false;
      }

      isLoading = true;
      notifyListeners();

      await authService.register(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text
      );

      isLoading = false;
      notifyListeners();

      clearState();

      return true;
    }catch(e){
      isLoading = false;
      notifyListeners();

      if(e.toString().contains("must be a valid email")){
        showSnackBar(
            context: context,
            text: AppLocalizations.of(context)!.validEmailValidationErrorText,
            backgroundColor: errorColor
        );
      }

      if(e.toString().contains("Email is already taken")){
        showSnackBar(
            context: context,
            text: AppLocalizations.of(context)!.emailAlreadyRegisterErrorText,
            backgroundColor: errorColor
        );
      }

      return false;
    }
  }

  void clearState(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    isFormValid = false;
    isNameValid = false;
    isEmailValid = false;
    isPasswordValid = false;
    isConfirmPasswordValid = false;
  }
}