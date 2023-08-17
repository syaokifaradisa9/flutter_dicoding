import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/services/favorite_service.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class RestaurantPage extends StatefulWidget {
  static const routeName = '/restaurant';
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  var isInit = true;
  List<Restaurant> restaurants = [];
  List<Restaurant> restaurantFilters = [];

  @override
  void initState(){
    super.initState();
    dataInit();
  }

  void dataInit() async{
    restaurants = Restaurant.parseRestaurants(
      await DefaultAssetBundle.of(context).loadString("assets/restaurants.json")
    );

    setState(() {
      restaurantFilters = restaurants;
      isInit = false;
    });
  }

  void search(String text){
    restaurantFilters = [];
    for(Restaurant restaurant in restaurants){
      if(restaurant.name.toLowerCase().contains(text.toLowerCase())){
        restaurantFilters.add(restaurant);
      }
    }
  }

  Widget _listBuilder(){
    return isInit ? const Center(child: CircularProgressIndicator()) :
      restaurantFilters.isNotEmpty ? GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          restaurantFilters.length,
          (index) => Padding(
            padding: const EdgeInsets.all(3),
            child: RestaurantCard(
              restaurant: restaurantFilters[index],
              onTapCallback: () async{
                FocusScope.of(context).unfocus();
                bool isRestaurantFavorite = await FavoriteService.checkIsFavorite(restaurantFilters[index].id);
                if(context.mounted){
                  Navigator.pushNamed(context, DetailRestaurant.routeName, arguments: [
                    restaurantFilters[index],
                    isRestaurantFavorite,
                  ]);
                }
              },
            ),
          ),
        ),
      ) : Center(
        child: Text(
          "Data Restoran Tidak Tersedia",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.black38
          ),
        ),
      );
  }

  Widget _buildContent(BuildContext context){
    return Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 3),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Cari Restoran"),
                onChanged: (text){
                  setState(() {
                    search(text);
                  });
                },
              ),
            ),
            const SizedBox(height: 4),
            Expanded(child: _listBuilder())
          ],
        ),
    );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant App")),
      body: _buildContent(context),
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Restaurant App"),
        transitionBetweenRoutes: false,
      ),
      child: _buildContent(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

