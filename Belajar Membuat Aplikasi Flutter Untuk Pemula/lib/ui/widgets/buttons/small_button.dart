part of '../widgets.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color buttonColor;
  final Color textColor;
  final String text;

  const SmallButton({
    required this.onTap,
    required this.textColor,
    required this.buttonColor,
    required this.text,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: buttonColor
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.rubik(
            fontSize: 11,
            color: textColor
          )
        ),
      )
    );
  }
}
