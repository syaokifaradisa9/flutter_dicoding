import 'package:flutter/material.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/values.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final Color buttonColor;
  final Color textColor;
  final String textLabel;
  final IconData icon;

  const Button({
    required this.onTap,
    required this.buttonColor,
    required this.textColor,
    required this.icon,
    required this.textLabel,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: primaryColor,
            surfaceTintColor: primaryColor
          ),
          onPressed: onTap,
          child: SizedBox(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: textColor,
                ),
                const SizedBox(width: 3),
                Text(
                  textLabel,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: textColor
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
