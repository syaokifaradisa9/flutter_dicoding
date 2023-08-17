import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/config/const_values.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant_review.dart';

class ReviewService{
  static Future<List<RestaurantReview>> addReview(
      String restaurantId,
      String name,
      String review
    ) async{

    var res = await http.post(
      Uri.parse('$apiBaseUrl/review'),
      body: {
        'id': restaurantId,
        'name': name,
        'review': review
      }
    );

    var jsonResult = jsonDecode(res.body);

    List<RestaurantReview> reviews = [];
    if(!jsonResult['error']){
      var list = jsonResult['customerReviews'] as List;
      reviews = list.map((val) => RestaurantReview.fromJson(val)).toList();
    }

    return reviews;
  }

  static Future<List<RestaurantReview>> getReviews(String restaurantId) async{
    try{
      http.Response res = await http.get(
          Uri.parse('$apiBaseUrl/detail/$restaurantId')
      );

      var jsonResult = jsonDecode(res.body);
      DetailRestaurant restaurant = DetailRestaurant.fromJson(
          jsonResult['restaurant']
      );

      List<RestaurantReview> reviews = restaurant.reviews;

      if(reviews.isEmpty){
        throw "isEmpty";
      }
      return reviews;
    }catch(error){
      if(error == 'isEmpty'){
        throw "Review Masih Belum Ada!";
      }
      throw "Koneksi Internet Tidak Tersedia, Silahkan Refresh Kembali!";
    }
  }
}