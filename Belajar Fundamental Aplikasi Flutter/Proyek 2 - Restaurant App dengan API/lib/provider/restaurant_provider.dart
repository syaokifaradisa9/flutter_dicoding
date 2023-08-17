import 'package:flutter/material.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/services/restaurant_service.dart';

class RestaurantProvider with ChangeNotifier{
  bool isLoading = true;
  bool isError = false;
  String errorMessage = "";
  List<Restaurant> restaurants = [];

  RestaurantProvider(){
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
      restaurants = await RestaurantService.getRestaurants();
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
        restaurants = await RestaurantService.searchRestaurants(text);
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
      DetailRestaurant restaurant = await RestaurantService.getRestaurant(
          restaurants[index].id
      );

      if(context.mounted) {
        Navigator.pushNamed(
            context,
            DetailRestaurantPage.routeName,
            arguments: restaurant
        );
      }
    }catch(error){
      errorMessage = error.toString();
      setErrorStatus(true);
    }
  }
}