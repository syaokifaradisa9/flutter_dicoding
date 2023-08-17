import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';
import 'package:restaurant_app/pages/splashscreen.dart';

Map<String, WidgetBuilder> routes(BuildContext context) => {
  SplashScreen.routeName: (context) => const SplashScreen(),
  RestaurantPage.routeName: (context) => const RestaurantPage(),
  DetailRestaurant.routeName: (context) => DetailRestaurant(
    restaurant: (ModalRoute.of(context)?.settings.arguments as List)[0],
    isFavorite: (ModalRoute.of(context)?.settings.arguments as List)[1]
  )
};