import 'package:flutter/material.dart';
import 'package:story_app/config/colors.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
  Color backgroundColor = successColor,
  Color textColor = Colors.white,
}){
  final snackBar = SnackBar(
    duration: const Duration(seconds: 5),
    backgroundColor: backgroundColor,
    content: Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

