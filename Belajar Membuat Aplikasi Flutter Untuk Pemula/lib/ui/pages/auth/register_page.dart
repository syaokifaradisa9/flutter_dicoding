part of '../pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegisterProvider>(context);
    if(isInit){
      provider.reset();
      isInit = false;
      setState(() {});
    }

    return GeneralPageLayout(
        title: "Pendaftaran Akun",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
              children: [
                const SizedBox(height: 24),
                const TextLabel(value: "Nama"),
                const SizedBox(height: 8),
                GeneralForm(
                  hint: "Masukkan nama lengkap",
                  onChange: provider.checkName
                ),
                const SizedBox(height: 17),
                const TextLabel(value: "Email"),
                const SizedBox(height: 8),
                GeneralForm(
                    hint: "example@gmail.com",
                    onChange: provider.checkEmail
                ),
                const SizedBox(height: 17),
                const TextLabel(value: "Password"),
                const SizedBox(height: 8),
                GeneralForm(
                  hint: "Masukkan Password Akun",
                  onChange: provider.checkPassword,
                  isHidden: true,
                ),
                const SizedBox(height: 17),
                const TextLabel(value: "Konfirmasi Password"),
                const SizedBox(height: 8),
                GeneralForm(
                  hint: "Masukkan Password Kembali",
                  onChange: provider.checkConfirmationPassword,
                  isHidden: true,
                ),
                const SizedBox(height: 17),
                GeneralButton(
                    textButton: "Daftar",
                    color: provider.isFormValid ? primaryColor : primaryColor.withOpacity(0.5),
                    onTap: () async{
                      if(provider.isConfirmationPasswordValid){
                        if(provider.isFormValid){
                          EasyLoading.show();
                          SignInSignUpResult result = await AuthService.signUpWithEmail(provider.email!, provider.password!, provider.name!);
                          EasyLoading.dismiss();
                          if(result.user != null){
                            Get.off(const RegisterSuccessPage());
                          }else{
                            EasyLoading.showError("Pendaftaran gagal, silahkan coba lagi!");
                          }
                        }else{
                          EasyLoading.showError("Isikan form dengan benar!");
                        }
                      }else{
                        EasyLoading.showError("Konfirmasi password tidak sama dengan password!");
                      }
                    }
                )
              ]
          )
        )
    );
  }
}

