import 'dart:convert';

class Restaurant{
  late final String id;
  late final String name;
  late final String description;
  late final String pictureUrl;
  late final String city;
  late final double rating;
  late final List<String> foods;
  late final List<String> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks
  });

  Restaurant.fromJson(Map<String, dynamic> restaurants){
    id = restaurants['id'];
    name = restaurants['name'];
    description = restaurants['description'];
    pictureUrl = restaurants['pictureId'];
    city = restaurants['city'];
    rating = double.parse(restaurants['rating'].toString());

    var foodsList = restaurants['menus']['foods'];
    foods = foodsList.map<String>((food) => food['name'].toString()).toList();

    var drinksList = restaurants['menus']['drinks'];
    drinks = drinksList.map<String>((drink) => drink['name'].toString()).toList();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name' : name,
    'description' : description,
    'pictureId' : pictureUrl,
    'city' : city,
    'rating': rating.toDouble(),
    'menus': {
      'foods' : foods.map((food) => {
        'name': food,
      }).toList(),
      'drinks': drinks.map((drink) => {
        'name': drink,
      }).toList()
    }
  };

  static List<Restaurant> parseRestaurants(String? json){
    if(json == null) return [];

    var parsedJson = jsonDecode(json);
    return parsedJson['restaurants'].map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
  }
}