import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService{
  static void addToFavorite(String id) async{
    final prefs = await SharedPreferences.getInstance();

    List<String> favIds = [];
    if(prefs.containsKey("favorite_restaurant")){
      favIds = await getFavoriteRestaurantsId();
    }

    if(!favIds.contains(id)){
      favIds.add(id);
      prefs.setStringList("favorite_restaurant", favIds);
    }
  }

  static getFavoriteRestaurantsId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("favorite_restaurant");
  }

  static Future<bool> checkIsFavorite(String id) async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("favorite_restaurant")){
      final List<String> favoriteId = await getFavoriteRestaurantsId();
      return favoriteId.contains(id);
    }

    return false;
  }

  static void deleteFavoriteRestaurant(String id) async{
    final prefs = await SharedPreferences.getInstance();

    List<String> favIds = [];
    if(prefs.containsKey("favorite_restaurant")){
      favIds = await getFavoriteRestaurantsId();
    }

    if(favIds.contains(id)){
      favIds.remove(id);
      prefs.setStringList("favorite_restaurant", favIds);
    }
  }
}