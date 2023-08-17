import 'package:flutter/material.dart';
import 'package:story_app/config/values.dart';

class AuthFormField extends StatelessWidget {
  final String label;
  final Function(String) onChange;
  final TextEditingController controller;
  final bool isHidden;

  const AuthFormField({
    required this.label,
    required this.controller,
    required this.onChange,
    this.isHidden = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.white
            ),
          ),
          const SizedBox(height: 3),
          TextFormField(
            onChanged: onChange,
            cursorColor: Colors.white12,
            obscureText: isHidden,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
            ),
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              hintText: label,
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white60,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
