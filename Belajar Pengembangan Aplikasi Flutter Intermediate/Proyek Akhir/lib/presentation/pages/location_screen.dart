import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/presentation/widgets/placemark.dart';
import 'package:story_app/providers/google_map_provider.dart';
import 'package:story_app/routes/map_page_manager.dart';

class MapLocationScreen extends StatelessWidget {
  final VoidCallback onSelectGoogleMap;

  const MapLocationScreen({
    required this.onSelectGoogleMap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Widget googleMapContainer(){
      return Consumer<GoogleMapProvider>(
        builder: (context, provider, _) => GoogleMap(
          mapType: provider.mapType,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: provider.markers,
          initialCameraPosition: CameraPosition(
            zoom: 18,
            target: provider.currentLocation
          ),
          onMapCreated: provider.setMapController,
          onTap: provider.setCurrentLocationByMapClick
        )
      );
    }

    Widget googleMapActionButton(){
      return Column(
        children: [
          FloatingActionButton.small(
            onPressed: null,
            backgroundColor: primaryColor,
            child: PopupMenuButton<MapType>(
              onSelected: context.read<GoogleMapProvider>().changeMapType,
              offset: const Offset(0, 54),
              icon: const Icon(Icons.layers_outlined, color: Colors.white),
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<MapType>>[
                const PopupMenuItem<MapType>(
                  value: MapType.normal,
                  child: Text('Normal'),
                ),
                const PopupMenuItem<MapType>(
                  value: MapType.satellite,
                  child: Text('Satellite'),
                ),
                const PopupMenuItem<MapType>(
                  value: MapType.terrain,
                  child: Text('Terrain'),
                ),
                const PopupMenuItem<MapType>(
                  value: MapType.hybrid,
                  child: Text('Hybrid'),
                ),
              ],
            ),
          ),
          FloatingActionButton.small(
            heroTag: "zoom-in",
            backgroundColor: primaryColor,
            onPressed: context.read<GoogleMapProvider>().zoomInMap,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          FloatingActionButton.small(
            heroTag: "zoom-out",
            backgroundColor: primaryColor,
            onPressed: context.read<GoogleMapProvider>().zoomOutMap,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
          FloatingActionButton.small(
              backgroundColor: primaryColor,
              child: const Icon(Icons.my_location, color: Colors.white),
              onPressed: () async{
                await context.read<GoogleMapProvider>()
                    .setCurrentLocationByButtonClick();
              }
          )
        ],
      );
    }

    Widget placeMarkContainer(){
      return Consumer<GoogleMapProvider>(
        builder: (context, provider, _){
          if(provider.placeMark != null){
            var placeMark = provider.placeMark!;
            String address = "${placeMark.subLocality} "
              "${placeMark.locality} "
              "${placeMark.postalCode} "
              "${placeMark.country}";

            return PlaceMark(
              address: address,
              street: placeMark.street!,
              onSelectLocation: (){
                onSelectGoogleMap();
                context.read<PageManager>().returnData(
                  provider.currentLocation
                );
              }
            );
          }else{
            return const SizedBox();
          }
        }
      );
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            googleMapContainer(),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  googleMapActionButton(),
                  const SizedBox(height: 4),
                  placeMarkContainer()
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
