import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/config/colors.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/favorite_service.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailRestaurant extends StatefulWidget {
  static const routeName = '/detail-restaurant';
  final Restaurant restaurant;
  final bool isFavorite;

  const DetailRestaurant({
    required this.restaurant,
    required this.isFavorite,
    Key? key
  }) : super(key: key);

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> with TickerProviderStateMixin{
  Widget _buildContent(BuildContext context){
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, _){
          return [
            SliverAppBar(
              expandedHeight: 200,
              leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 8, top: 14),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundIconColor,
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              actions: [
                Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 4, top: 14),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundIconColor,
                  ),
                  child: FavoriteButton(
                    iconSize: 40,
                    isFavorite: widget.isFavorite,
                    iconDisabledColor: Colors.white,
                    valueChanged: (isFavorite) async {
                      if(isFavorite){
                        FavoriteService.addToFavorite(widget.restaurant.id);
                      }else{
                        FavoriteService.deleteFavoriteRestaurant(widget.restaurant.id);
                      }
                    },
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.restaurant.pictureUrl,
                  child: Image.network(
                    widget.restaurant.pictureUrl,
                    fit: BoxFit.cover
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        widget.restaurant.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.place, color: placeIconColor),
                          const SizedBox(width: 3),
                          Text(
                            widget.restaurant.city,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: ratingIconColor),
                      const SizedBox(width: 4),
                      Text(
                          widget.restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.titleMedium
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deskripsi",
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  Text(
                    widget.restaurant.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Menu Makanan",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              widget.restaurant.foods.length,
                              (index) => Text("${index + 1}.  ${widget.restaurant.foods[index]}")
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Menu Minuman",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              widget.restaurant.drinks.length,
                              (index) => Text("${index + 1}.  ${widget.restaurant.drinks[index]}")
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(body: _buildContent(context));
  }

  Widget _buildIos(BuildContext context){
    return CupertinoPageScaffold(child: _buildContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}