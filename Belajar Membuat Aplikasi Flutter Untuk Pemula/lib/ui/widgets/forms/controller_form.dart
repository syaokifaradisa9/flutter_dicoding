part of '../widgets.dart';

class ControllerForm extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const ControllerForm({
    required this.controller,
    required this.hint,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: formTextStyle,
      controller: controller,
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
