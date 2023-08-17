import 'dart:convert';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/services/favorite_service.dart';

class RestaurantService{
  static const _apiBaseUrl = 'https://restaurant-api.dicoding.dev';
  final http.Client client;
  RestaurantService({required this.client});

  Future<List<Restaurant>> getRestaurants() async{
    try{
      var res = await client.get(Uri.parse('$_apiBaseUrl/list'));
      var jsonResult = jsonDecode(res.body);

      List<Restaurant> restaurants = [];
      if(!jsonResult['error']){
        var list = jsonResult['restaurants'] as List;
        restaurants = list.map((val) => Restaurant.fromJson(val)).toList();
      }

      if(restaurants.isEmpty){
        throw "isEmpty";
      }

      return restaurants;
    }catch(error){
      if(error == "isEmpty"){
        throw "Data Restoran Tidak Tersedia!";
      }
      throw "Koneksi Internet Tidak Tersedia\nSilahkan Refresh Kembali!";
    }
  }

  Future<DetailRestaurant> getRestaurant(String id) async{
    try{
      http.Response res = await client.get(Uri.parse('$_apiBaseUrl/detail/$id'));
      var jsonResult = jsonDecode(res.body);
      DetailRestaurant restaurant = DetailRestaurant.fromJson(
          jsonResult['restaurant']
      );

      restaurant.isFavorite = await FavoriteService().checkIsFavorite(id);

      return restaurant;
    }catch(error){
      throw "Koneksi Internet Tidak Tersedia\nSilahkan Refresh Kembali!";
    }
  }

  Future<List<Restaurant>> searchRestaurants(String text) async{
    try{
      text = text.replaceAll(' ', '%20');
      var res = await client.get(Uri.parse('$_apiBaseUrl/search?q=$text'));
      var jsonResult = jsonDecode(res.body);

      List<Restaurant> restaurants = [];
      if(!jsonResult['error']){
        var list = jsonResult['restaurants'] as List;
        restaurants = list.map((val) => Restaurant.fromJson(val)).toList();
      }

      if(restaurants.isEmpty){
        throw "isEmpty";
      }

      return restaurants;
    }catch(error){
      if(error == "isEmpty"){
        throw "Data Restoran Tidak Ditemukan!";
      }
      throw "Koneksi Internet Tidak Tersedia\nSilahkan Refresh Kembali!";
    }
  }
}