import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/restaurant_review.dart';
import 'package:restaurant_app/services/favorite_service.dart';

class DetailRestaurant{
  late final Restaurant restaurant;
  late final bool isFavorite;
  late final List<String> categories;
  late final List<String> foods;
  late final List<String> drinks;
  late final List<RestaurantReview> reviews;

  DetailRestaurant({
    required this.restaurant,
    required this.categories,
    required this.foods,
    required this.drinks,
    required this.reviews,
  });

  DetailRestaurant.fromJson(Map<String, dynamic> json){
    restaurant = Restaurant.fromJson(json);

    var listCategories = json['categories'] as List;
    categories = listCategories.map<String>(
      (val) => val['name'].toString()
    ).toList();

    var listFoods = json['menus']['foods'] as List;
    foods = listFoods.map<String>((val) => val['name'].toString()).toList();

    var listDrinks = json['menus']['drinks'] as List;
    drinks = listDrinks.map<String>((val) => val['name'].toString()).toList();

    var listReview = json['customerReviews'] as List;
    reviews = listReview.map<RestaurantReview>(
      (val) => RestaurantReview.fromJson(val)
    ).toList();

    checkIsFavorite();
  }

  void checkIsFavorite() async{
    isFavorite = await FavoriteService.checkIsFavorite(restaurant.id) ?? false;
  }
}