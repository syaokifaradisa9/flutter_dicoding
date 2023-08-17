import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant_review.dart';
import 'package:restaurant_app/services/review_service.dart';

class ReviewProvider with ChangeNotifier{
  List<RestaurantReview> reviews = [];
  bool isPostLoading = false;
  bool isDataLoading = true;

  bool isError = false;
  String errorMessage = '';

  void setDataLoading(bool status){
    isDataLoading = status;
    notifyListeners();
  }

  void setPostLoading(bool status){
    isPostLoading = status;
    notifyListeners();
  }

  void setErrorDataStatus(status){
    isError = status;
    notifyListeners();
  }

  ReviewProvider(String restaurantId){
    setInitData(restaurantId);
  }

  setInitData(String restaurantId) async{
    setDataLoading(true);
    try{
      reviews = await ReviewService.getReviews(restaurantId);
      setErrorDataStatus(false);
    }catch(error){
      errorMessage = error.toString();
      setErrorDataStatus(true);
    }
    setDataLoading(false);
  }

  void addReview(
      BuildContext context,
      String restaurantId,
      String name,
      String review
    ) async{

    setPostLoading(true);
    List<RestaurantReview> newReviews = await ReviewService.addReview(
      restaurantId,
      name,
      review
    );

    String message = '';
    Color notificationColor = Colors.green;
    if(reviews.length < newReviews.length){
      reviews = newReviews;
      message = 'Sukses Menambahkan Review';
    }else{
      message = 'Gagal Menambahkan Review\nSilahkan Coba Lagi!';
      notificationColor = Colors.red;
    }

    var snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(message),
      backgroundColor: notificationColor,
    );

    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setPostLoading(false);
  }
}