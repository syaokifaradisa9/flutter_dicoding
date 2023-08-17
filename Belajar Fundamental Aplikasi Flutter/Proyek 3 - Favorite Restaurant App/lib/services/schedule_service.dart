import 'dart:isolate';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/notification_service.dart';
import 'package:restaurant_app/services/restaurant_service.dart';

final ReceivePort port = ReceivePort();

class ScheduleService{
  static ScheduleService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  ScheduleService._internal(){
    _instance = this;
  }

  factory ScheduleService() => _instance ?? ScheduleService._internal();

  void initializeIsolate(){
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async{
    final NotificationService notificationService = NotificationService();
    List<Restaurant> res = await RestaurantService(
      client: http.Client()
    ).getRestaurants();

    Restaurant randomRestaurant = (res..shuffle()).first;

    DetailRestaurant restaurant = await RestaurantService(
      client: http.Client()
    ).getRestaurant(randomRestaurant.id);

    await notificationService.showNotification(
        notificationsPluginPlugin,
        restaurant
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}