part of 'layouts.dart';

class GeneralPageLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const GeneralPageLayout({
    required this.title,
    required this.child,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            title,
            style: GoogleFonts.rubik(
              fontSize: 17,
              fontWeight: FontWeight.w600
            )
          ),
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: child
        )
      ),
    );
  }
}
