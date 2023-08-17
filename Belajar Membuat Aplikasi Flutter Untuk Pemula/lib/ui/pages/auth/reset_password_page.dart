part of '../pages.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ResetPasswordProvider>(context);
    if(isInit){
      provider.reset();
      isInit = false;
      setState(() {});
    }

    return GeneralPageLayout(
        title: "Reset Password",
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35),
                  const TextLabel(value: "Email"),
                  const SizedBox(height: 8),
                  GeneralForm(
                      hint: "example@gmail.com",
                      onChange: provider.checkEmail
                  ),
                  const SizedBox(height: 17),
                  GeneralButton(
                      textButton: "Reset",
                      textColor: Colors.white,
                      color: (provider.isFormValid ?? false) ? secondaryColor : secondaryColor.withOpacity(0.5),
                      onTap: () async{
                        if(provider.isFormValid ?? false){

                          EasyLoading.show();
                          String result = await AuthService.resetPassword(provider.email!);
                          EasyLoading.dismiss();

                          if(result == "Sukses"){
                            Get.back();
                            EasyLoading.showSuccess("Reset password sukses, silahkan cek email anda!");
                          }else{
                            EasyLoading.showError("Reset password gagal, silahkan coba lagi!");
                          }
                        }else{
                          EasyLoading.showError("Isikan email yang benar untuk mereset password!");
                        }
                      }
                  )
                ]
            )
        )
    );
  }
}

