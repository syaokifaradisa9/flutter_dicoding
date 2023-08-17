import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/config/colors.dart';
import 'package:restaurant_app/config/const_values.dart';
import 'package:restaurant_app/helper/navigation_helper.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/pages/restaurant_review_page.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/services/review_service.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:http/http.dart' as http;

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail-restaurant';
  final DetailRestaurant restaurant;

  const DetailRestaurantPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  Widget buildContent(BuildContext context){
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled){
          return [
            SliverAppBar(
              expandedHeight: 200,
              leading: GestureDetector(
                onTap: (){
                  NavigatorHelper.back();
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
                    isFavorite: restaurant.isFavorite,
                    iconDisabledColor: Colors.white,
                    valueChanged: (isFavorite) async {
                      if(isFavorite){
                        Provider.of<FavoriteProvider>(
                            context,
                            listen: false
                        ).addRestaurant(restaurant.restaurant);
                      }else{
                        Provider.of<FavoriteProvider>(
                            context,
                            listen: false
                        ).deleteRestaurant(restaurant.restaurant.id);
                      }
                    },
                  ),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: restaurant.restaurant.pictureId,
                  child: Image.network(
                    largeResolutionPictureUrl + restaurant.restaurant.pictureId,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, loadingProgress){
                      if(loadingProgress == null){
                        return child;
                      }else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  )
                ),
              ),
            )
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
                          restaurant.restaurant.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: MediaQuery.of(context).size.width - 28,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.place, color: placeIconColor),
                                  const SizedBox(width: 3),
                                  Text(
                                    restaurant.restaurant.city,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(Icons.star, color: ratingIconColor),
                                  const SizedBox(width: 4),
                                  Text(
                                      restaurant.restaurant.rating.toString(),
                                      style: Theme.of(context).textTheme.titleMedium
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Kategori Restoran",
                      style: Theme.of(context).textTheme.titleSmall
                  ),
                  const SizedBox(height: 6),
                  Row(
                      children: List.generate(
                          restaurant.categories.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor
                            ),
                            child: Text(
                              restaurant.categories[index],
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                      )
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
                    restaurant.restaurant.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
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
                    "Menu Makanan",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      restaurant.foods.length,
                        (index) => Text(
                          "${index + 1}.  ${restaurant.foods[index]}"
                        )
                    ),
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
                    "Menu Minuman",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      restaurant.drinks.length,
                        (index) => Text(
                          "${index + 1}.  ${restaurant.drinks[index]}"
                        )
                    ),
                  ),
                ],
              )
            ),
            GestureDetector(
              onTap: () async{
                Provider.of<ReviewProvider>(context, listen: false).setInitData(
                  restaurant.reviews!
                );

                await Navigator.pushNamed(
                  context,
                  RestaurantReviewPage.routeName,
                  arguments: [
                    restaurant.restaurant.id,
                    restaurant.restaurant.name
                  ]
                );

                restaurant.reviews = await ReviewService(
                  client: http.Client()
                ).getReviews(restaurant.restaurant.id);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                height: 50,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.center,
                child: Text(
                  "Lihat Review",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(body: buildContent(context));
  }

  Widget _buildIos(BuildContext context){
    return CupertinoPageScaffold(child: buildContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
