part of '../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginProvider>(context);
    if(isInit){
      provider.reset();
      isInit = false;
      setState(() {});
    }

    return SafeArea(
        child: Scaffold(
            body: Container(
                width: Get.width,
                height: Get.height,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Center(
                          child: Image.asset(
                              "assets/illustrations/login.png",
                              width: 100
                          )
                        ),
                        const SizedBox(height: 30),
                        const TextLabel(value: "Email"),
                        const SizedBox(height: 8),
                        GeneralForm(
                          hint: "example@gmail.com",
                          onChange: provider.checkEmail
                        ),
                        const SizedBox(height: 17),
                        const TextLabel(value: "Password"),
                        const SizedBox(height: 4),
                        GeneralForm(
                          hint: "Masukkan password",
                          isHidden: true,
                          onChange: provider.checkPassword
                        ),
                        const SizedBox(height: 12),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                                onTap: (){
                                  Get.to(ResetPasswordPage());
                                },
                                child: TextLabel(
                                  value: "Lupa Password?",
                                  color: primaryTextColor.withOpacity(0.85),
                                )
                            )
                        ),
                        const SizedBox(height: 12),
                        GeneralButton(
                            textButton: "Login",
                            color: provider.isFormValid ? primaryColor : primaryColor.withOpacity(0.5),
                            onTap: () async{
                              if(provider.isFormValid){
                                EasyLoading.show();
                                SignInSignUpResult result = await AuthService.signInWithEmail(provider.email, provider.password);
                                EasyLoading.dismiss();
                                if(result.user != null){
                                  Get.offAll(MainRoute());
                                }else{
                                  EasyLoading.showError("Gagal login, silahkan coba lagi!");
                                }
                              }else{
                                EasyLoading.showError("Isikan email dan password dengan benar!");
                              }
                            }
                        ),
                        const SizedBox(height: 12),
                        Row(
                            children: [
                              Text("Belum punya akun? ", style: GoogleFonts.rubik(
                                fontSize: 12,
                                color: primaryTextColor,
                              )),
                              GestureDetector(
                                onTap: (){
                                  Get.to(RegisterPage());
                                },
                                child: const TextLabel(value: "Daftar Disini"),
                              )
                            ]
                        )
                      ]
                  )
                )
            )
        )
    );
  }
}

