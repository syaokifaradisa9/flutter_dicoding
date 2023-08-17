part of '../widgets.dart';

class TextLabel extends StatelessWidget {
  final String value;
  final Color color;

  const TextLabel({
    required this.value,
    this.color = primaryTextColor,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        value,
        style: formLabelTextStyle.copyWith(
          color: color
        )
    );
  }
}
