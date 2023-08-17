import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Dicostory",
              style: GoogleFonts.abyssinicaSil(
                fontSize: 32,
                color: Colors.white,
              )
            ),
            Text(
              AppLocalizations.of(context)!.appSubTitle,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white70
              ),
            ),
          ],
        ),
      ),
    );
  }
}
