part of '../widgets.dart';

class GeneralButton extends StatelessWidget {
  final VoidCallback onTap;
  final String textButton;
  final Color textColor;
  final Color color;

  const GeneralButton({
    required this.onTap,
    required this.textButton,
    this.color = primaryColor,
    this.textColor = primaryTextColor,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: Get.width,
          height: 43,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(7)
          ),
          alignment: Alignment.center,
          child: TextLabel(
            value: textButton,
            color: textColor
          )
      ),
    );
  }
}
