import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/config/values.dart';
import 'package:story_app/presentation/widgets/auth_form.dart';
import 'package:story_app/presentation/widgets/button.dart';
import 'package:story_app/providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const LoginScreen({
    required this.onLogin,
    required this.onRegister,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Widget brandContainer(){
      return Column(
        children: [
          Text(
            "Dicostory",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.appSubTitle,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      );
    }

    Widget emailForm(){
      return AuthFormField(
        label: "Email",
        controller: Provider.of<LoginProvider>(context).emailController,
        onChange: Provider.of<LoginProvider>(context).onChangeEmailForm,
      );
    }

    Widget passwordForm(){
      return AuthFormField(
        label: "Password",
        controller: Provider.of<LoginProvider>(context).passwordController,
        isHidden: true,
        onChange: Provider.of<LoginProvider>(context).onChangePasswordForm
      );
    }

    Widget loginButton(){
      return Consumer<LoginProvider>(
          builder: (context, provider, _) => !provider.isLoading ? Button(
            buttonColor: Colors.white.withOpacity(
              provider.isFormValid ? 1: 0.5
            ),
            textColor: primaryColor,
            icon: Icons.login,
            textLabel: "Login",
            onTap: onLogin
          ) : const CircularProgressIndicator(color: Colors.white)
      );
    }

    Widget registerLabel(){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${AppLocalizations.of(context)!.registerDescription} ",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white70
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
            ),
            onPressed: onRegister,
            child: Text(
              AppLocalizations.of(context)!.registerLabel,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ],
      );
    }

    Widget content(){
      return Column(
        mainAxisAlignment: isMobile ?
          MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          brandContainer(),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: emailForm(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: passwordForm(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: loginButton()
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: registerLabel()
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(child: SingleChildScrollView(child: content())),
      ),
    );
  }
}
