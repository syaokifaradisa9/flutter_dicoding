import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/services/favorite_service.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurant_app/services/review_service.dart';
import 'package:restaurant_app/services/setting_service.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ReviewProvider>(
      create: (context) => ReviewProvider(
          service: ReviewService(
            client: http.Client(),
          )
      )
  ),
  ChangeNotifierProvider<RestaurantProvider>(
    create: (context) => RestaurantProvider(
      service: RestaurantService(
        client: http.Client()
      )
    )
  ),
  ChangeNotifierProvider<FavoriteProvider>(
    create: (context) => FavoriteProvider(
      service: FavoriteService()
    )
  ),
  ChangeNotifierProvider<SchedulingProvider>(
    create: (context) => SchedulingProvider(
      settingService: SettingService()
    )
  )
];