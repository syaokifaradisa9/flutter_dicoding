import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const routeName = '/favorite-restaurant-page';

  const RestaurantFavoritePage({Key? key}) : super(key: key);

  Widget _buildContent(BuildContext context){
    return Consumer<FavoriteProvider>(
      builder: (context, provider, _){
        if(provider.restaurants.isEmpty){
          return Center(
            child: Text(
              "Restoran Favorit Masih Kosong",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black38
              )
            )
          );
        }else{
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              provider.restaurants.length,
                  (index) => Padding(
                padding: const EdgeInsets.all(3),
                child: RestaurantCard(
                  restaurant: provider.restaurants[index],
                  onTapCallback: () async{
                    FocusScope.of(context).unfocus();

                    DetailRestaurant restaurant = await RestaurantService(
                        client: http.Client()
                    ).getRestaurant(
                        provider.restaurants[index].id
                    );

                    if(context.mounted){
                      Navigator.pushNamed(
                          context,
                          DetailRestaurantPage.routeName,
                          arguments: restaurant
                      );
                    }
                  },
                ),
              ),
            ),
          );
        }
      }
    );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Restoran favorit",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white
            ),
          )
        ),
        body: _buildContent(context)
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Restoran favorit",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white
            ),
          ),
          transitionBetweenRoutes: false,
        ),
        child: _buildContent(context)
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
