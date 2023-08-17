import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/config/values.dart';
import 'package:story_app/presentation/widgets/auth_form.dart';
import 'package:story_app/presentation/widgets/button.dart';
import 'package:story_app/providers/register_provider.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const RegisterScreen({
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
          )
        ],
      );
    }

    Widget nameForm(){
      return AuthFormField(
        label: AppLocalizations.of(context)!.nameFormLabel,
        controller: Provider.of<RegisterProvider>(context).nameController,
        onChange: Provider.of<RegisterProvider>(context).onChangeNameForm
      );
    }

    Widget emailForm(){
      return AuthFormField(
        label: "Email",
        controller: Provider.of<RegisterProvider>(context).emailController,
        onChange: Provider.of<RegisterProvider>(context).onChangeEmailForm,
      );
    }

    Widget passwordForm(){
      return AuthFormField(
        label: "Password",
        controller: Provider.of<RegisterProvider>(
          context
        ).passwordController,
        isHidden: true,
        onChange: Provider.of<RegisterProvider>(
          context
        ).onChangePasswordForm
      );
    }

    Widget confirmationPasswordForm(){
      return AuthFormField(
        label: AppLocalizations.of(context)!.confirmPasswordLabel,
        controller: Provider.of<RegisterProvider>(
          context
        ).confirmPasswordController,
        isHidden: true,
        onChange: Provider.of<RegisterProvider>(
          context
        ).onChangeConfirmPasswordForm
      );
    }

    Widget registerButton(){
      return Consumer<RegisterProvider>(
        builder: (context, provider, _) => provider.isLoading ?
        const Center(
          child: CircularProgressIndicator(color: Colors.white)
        ) : Button(
            buttonColor: Colors.white.withOpacity(
              provider.isFormValid ? 1 : 0.5
            ),
            textColor: primaryColor,
            icon: Icons.login,
            textLabel: AppLocalizations.of(context)!.registerTextButton,
            onTap: onRegister
        ),
      );
    }

    Widget loginLabel(){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${AppLocalizations.of(context)!.loginDescription} ",
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
            onPressed: onLogin,
            child: Text(
              AppLocalizations.of(context)!.loginLabel,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w700
              ),
            ),
          )
        ],
      );
    }

    Widget formContent(){
      return Column(
        mainAxisAlignment: isMobile ?
          MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          brandContainer(),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: nameForm()
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: emailForm()
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: passwordForm()
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: confirmationPasswordForm()
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: registerButton()
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: loginLabel()
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: isMobile ? SingleChildScrollView(
            child: formContent(),
          ) : formContent(),
        ),
      ),
    );
  }
}
