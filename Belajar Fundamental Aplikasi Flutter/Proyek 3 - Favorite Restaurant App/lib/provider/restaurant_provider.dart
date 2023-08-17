import 'package:flutter/material.dart';
import 'package:restaurant_app/helper/navigation_helper.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';

import '../services/restaurant_service.dart';

class RestaurantProvider with ChangeNotifier{
  late final RestaurantService _service;
  bool isLoading = true;
  bool isError = false;
  String errorMessage = "";
  List<Restaurant> restaurants = [];

  RestaurantProvider({required RestaurantService service}){
    _service = service;
    setRestaurantData();
  }

  void setLoading(bool status){
    isLoading = status;
    notifyListeners();
  }

  void setErrorStatus(bool status){
    isError = status;
    notifyListeners();
  }

  void setRestaurantData() async{
    setLoading(true);
    try{
      restaurants = await _service.getRestaurants();
      setErrorStatus(false);
    }catch(error){
      errorMessage = error.toString();
      setErrorStatus(true);
    }
    setLoading(false);
  }

  void searchRestaurant(String text) async{
    if(text.isEmpty){
      setRestaurantData();
    }else{
      setLoading(true);
      try{
        restaurants = await _service.searchRestaurants(text);
        setErrorStatus(false);
      }catch(error){
        errorMessage = error.toString();
        setErrorStatus(true);
      }
      setLoading(false);
    }
  }

  void onTapRestaurant(BuildContext context, int index) async{
    try{
      DetailRestaurant restaurant = await _service.getRestaurant(
        restaurants[index].id
      );

      NavigatorHelper.intentWithData(
        DetailRestaurantPage.routeName,
        restaurant
      );

    }catch(error){
      errorMessage = error.toString();
      setErrorStatus(true);
    }
  }
}