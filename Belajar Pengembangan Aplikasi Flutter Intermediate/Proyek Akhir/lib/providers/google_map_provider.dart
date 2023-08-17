import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class GoogleMapProvider with ChangeNotifier{
  LatLng currentLocation = const LatLng(-6.8957473, 107.6337669);
  geo.Placemark? placeMark;
  MapType mapType = MapType.normal;
  final Set<Marker> markers = {};

  late GoogleMapController mapController;

  void changeMapType(MapType item){
    mapType = item;
    notifyListeners();
  }

  void setMapController(GoogleMapController mapController) async{
    this.mapController = mapController;
    await setCurrentLocation(latLng: currentLocation);
    notifyListeners();
  }

  void zoomInMap(){
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOutMap(){
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  void setCurrentLocationByMapClick(LatLng currentLatLang) async{
    await setCurrentLocation(latLng: currentLatLang);
  }

  Future<void> setCurrentLocationByButtonClick() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        debugPrint("Location services is not available");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        debugPrint("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    setCurrentLocation(
      latLng: LatLng(locationData.latitude!, locationData.longitude!)
    );
  }

  Future<void> setCurrentLocation({required LatLng latLng}) async{
    currentLocation = LatLng(latLng.latitude, latLng.longitude);

    var placeMarks = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude
    );

    placeMark = placeMarks.isNotEmpty ? placeMarks[0] : null;

    markers.clear();
    markers.addAll([
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: currentLocation,
        onTap: (){
          mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
        },
        infoWindow: InfoWindow(
          title: placeMark!.street
        )
      )
    ]);

    mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
    notifyListeners();
  }
}