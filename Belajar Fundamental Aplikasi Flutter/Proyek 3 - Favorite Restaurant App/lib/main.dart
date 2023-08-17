import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/config/colors.dart';
import 'package:restaurant_app/config/providers.dart';
import 'package:restaurant_app/config/routes.dart';
import 'package:restaurant_app/config/text_theme.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/pages/splashscreen.dart';
import 'package:restaurant_app/services/notification_service.dart';
import 'package:restaurant_app/services/schedule_service.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'helper/navigation_helper.dart';

final FlutterLocalNotificationsPlugin notificationsPluginPlugin =
  FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationService notificationService = NotificationService();
  final ScheduleService reminderService = ScheduleService();

  reminderService.initializeIsolate();

  if(Platform.isAndroid){
    await AndroidAlarmManager.initialize();
  }

  await notificationService.initNotifications(notificationsPluginPlugin);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationService _notificationService = NotificationService();

  Widget _buildAndroid(BuildContext context){
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Restaurant App',
      theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: primaryColor,
              titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
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
  void initState() {
    super.initState();
    _notificationService.configureSelectNotificationSubject(
      DetailRestaurantPage.routeName
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: PlatformWidget(
          iosBuilder: _buildIos,
          androidBuilder: _buildAndroid,
        )
    );
  }
}