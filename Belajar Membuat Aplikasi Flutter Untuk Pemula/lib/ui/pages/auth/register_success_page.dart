part of '../pages.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Spacer(),
            Image.asset("assets/illustrations/complete.png", width: 260),
            SizedBox(height: 12),
            Text(
              "Pendaftaran Berhasil",
              style: GoogleFonts.rubik(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Nikmati kemudahan mengelola transaksi penjualan tokomu",
              textAlign: TextAlign.justify,
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 13
              )
            ),
            SizedBox(height: 20),
            GeneralButton(
              textButton: "Login",
              color: secondaryColor,
              textColor: Colors.white,
              onTap: (){
                Get.offAll(LoginPage());
              }
            ),
            Spacer()
          ]
        )
      )
    );
  }
}
