import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/config/colors.dart';
import 'package:restaurant_app/config/routes.dart';
import 'package:restaurant_app/config/text_theme.dart';
import 'package:restaurant_app/pages/splashscreen.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context){
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: primaryColor,
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: textWhiteColor,
            )
          ),
          textTheme: textTheme
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes(context),
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoApp(
      theme: const CupertinoThemeData(
        primaryColor: primaryColor
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      iosBuilder: _buildIos,
      androidBuilder: _buildAndroid,
    );
  }
}