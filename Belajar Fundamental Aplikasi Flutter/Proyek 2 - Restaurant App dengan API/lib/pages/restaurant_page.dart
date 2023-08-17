import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class RestaurantPage extends StatelessWidget {
  static const routeName = '/restaurant';
  const RestaurantPage({Key? key}) : super(key: key);

  Widget _listBuilder(){
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _){
        if(provider.isLoading){
          return const Center(child: CircularProgressIndicator());
        }else{
          if(provider.isError){
            return Center(
              child: Text(
                provider.errorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black38
                ),
              ),
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
                      Provider.of<RestaurantProvider>(
                          context,
                          listen: false
                      ).onTapRestaurant(
                        context,
                        index,
                      );
                    },
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildContent(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(),
      child: Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, top: 3),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Consumer<RestaurantProvider>(
                  builder: (context, provider, _) => TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Cari Restoran"
                    ),
                    onChanged: (text){
                      provider.searchRestaurant(text);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(child: _listBuilder()),
            ],
          ),
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


