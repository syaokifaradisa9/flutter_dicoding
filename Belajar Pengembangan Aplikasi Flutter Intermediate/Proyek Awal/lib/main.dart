import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/config/text_theme.dart';
import 'package:story_app/providers/add_story_provider.dart';
import 'package:story_app/providers/detail_story_provider.dart';
import 'package:story_app/providers/login_provider.dart';
import 'package:story_app/providers/register_provider.dart';
import 'package:story_app/providers/story_provider.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/routes/router_delegate.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;

  @override
  void initState() {
    super.initState();
    myRouterDelegate = MyRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider(
          authService: di.locator())
        ),
        ChangeNotifierProvider(create: (context) => RegisterProvider(
          authService: di.locator()
        )),
        ChangeNotifierProvider(create: (context) => StoryProvider(
          storyService: di.locator()
        )),
        ChangeNotifierProvider(create: (context) => DetailStoryProvider(
          storyService: di.locator())
        ),
        ChangeNotifierProvider(create: (context) => AddStoryProvider(
          storyService: di.locator()
        ))
      ],
      child: MaterialApp(
          title: 'Dicostory',
          theme: ThemeData(
            textTheme: textTheme,
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', ''),
            Locale('en', ''),
          ],
          home: Router(
            routerDelegate: myRouterDelegate,
            backButtonDispatcher: RootBackButtonDispatcher(),
          )
      )
    );
  }
}