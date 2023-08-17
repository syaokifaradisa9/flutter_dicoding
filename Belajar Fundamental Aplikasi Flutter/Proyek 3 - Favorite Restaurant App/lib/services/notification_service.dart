import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/helper/navigation_helper.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationService{
  static NotificationService? _instance;

  NotificationService._internal(){
    _instance = this;
  }

  factory NotificationService() => _instance ?? NotificationService._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin plugin) async{
    var initializationSettingAndroid = const AndroidInitializationSettings(
      'app_icon'
    );

    var initializationSettingIos = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingIos,
    );

    await plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async{
        final payload = details.payload;
        selectNotificationSubject.add(payload ?? 'empty payload');
      }
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin plugin,
    DetailRestaurant restaurant
  ) async{

    var channelId = "1";
    var channelName = "channel_$channelId";
    var channelDescription = 'daily restaurant channel';

    var iosPlatformChannelSpecifics = const DarwinNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true)
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await plugin.show(
      0,
      restaurant.restaurant.name,
      "rekomendasi restoran untukmu!",
      platformChannelSpecifics,
      payload: jsonEncode(restaurant.toJson())
    );
  }

  void configureSelectNotificationSubject(String route){
    selectNotificationSubject.stream.listen((String payload) async {
      var restaurant = DetailRestaurant.fromJson(jsonDecode(payload));
      NavigatorHelper.intentWithData(route, restaurant);
    });
  }
}