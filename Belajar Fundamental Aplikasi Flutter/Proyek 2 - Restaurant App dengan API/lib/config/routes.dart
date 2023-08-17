import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';
import 'package:restaurant_app/pages/restaurant_review_page.dart';
import 'package:restaurant_app/pages/splash_screen.dart';

Map<String, WidgetBuilder> routes(BuildContext context) => {
  SplashScreen.routeName: (context) => const SplashScreen(),
  RestaurantPage.routeName: (context) => const RestaurantPage(),
  DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
    restaurant: ModalRoute.of(context)?.settings.arguments as DetailRestaurant
  ),
  RestaurantReviewPage.routeName: (context) => RestaurantReviewPage(
    restaurantId: (ModalRoute.of(context)?.settings.arguments as List)[0],
    restaurantName: (ModalRoute.of(context)?.settings.arguments as List)[1]
  )
};