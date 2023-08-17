part of '../widgets.dart';

class GeneralForm extends StatelessWidget {
  final String hint;
  final void Function(dynamic value) onChange;
  final bool isHidden;
  final TextInputType inputType;

  const GeneralForm({
    required this.hint,
    required this.onChange,
    this.isHidden = false,
    this.inputType = TextInputType.text,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      obscureText: isHidden,
      style: formTextStyle,
      keyboardType: inputType,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: formPlaceholderTextStyle,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        fillColor: formBackgroundColor,
        border: InputBorder.none
      ),
    );
  }
}
