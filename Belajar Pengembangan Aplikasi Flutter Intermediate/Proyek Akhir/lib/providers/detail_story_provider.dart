import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/services/story_service.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailStoryProvider with ChangeNotifier{
  late LatLng? currentLocation;
  geo.Placemark? placeMark;
  final Set<Marker> markers = {};

  StoryService storyService;
  DetailStoryProvider({required this.storyService});

  late Story story;
  bool isLoading = false;

  void getData(id) async{
    isLoading = true;
    notifyListeners();

    currentLocation = null;
    placeMark = null;

    story = await storyService.getDetail(id: id);
    isLoading = false;
    notifyListeners();

    if(story.latitude != null && story.longitude != null){
      currentLocation = LatLng(story.latitude!, story.longitude!);

      var placeMarks = await geo.placemarkFromCoordinates(
        story.latitude!,
        story.longitude!
      );

      placeMark = placeMarks.isNotEmpty ? placeMarks[0] : null;

      markers.clear();
      markers.addAll([
        Marker(
            markerId: const MarkerId("currentLocation"),
            position: currentLocation!,
            infoWindow: InfoWindow(
              title: placeMark!.street
            )
        )
      ]);

      notifyListeners();
    }
  }
}