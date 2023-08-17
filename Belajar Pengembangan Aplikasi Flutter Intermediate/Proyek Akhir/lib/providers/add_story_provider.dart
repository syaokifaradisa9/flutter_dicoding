import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/config/alert.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/services/story_service.dart';
import 'package:geocoding/geocoding.dart' as geo;

class AddStoryProvider with ChangeNotifier{
  bool isImageReady = false;
  bool isDescriptionFormValid = false;
  bool isFormValid = false;
  bool isLoading = false;

  LatLng? currentLocation;
  geo.Placemark? placeMark;

  late XFile? file;
  final StoryService storyService;
  final TextEditingController descriptionController = TextEditingController();

  AddStoryProvider({required this.storyService});

  void getImageFromGallery() async{
    var imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imagePick != null){
      file = imagePick;
      isImageReady = true;
      notifyListeners();
    }else{
      isImageReady = false;
    }

    isFormValid = isImageReady && isDescriptionFormValid;
    notifyListeners();
  }

  void getImageFromCamera() async{
    var imagePick = await ImagePicker().pickImage(source: ImageSource.camera);
    if(imagePick != null){
      file = imagePick;
      isImageReady = true;
      notifyListeners();
    }else{
      isImageReady = false;
    }

    isFormValid = isImageReady && isDescriptionFormValid;
    notifyListeners();
  }

  void onChangeDescriptionForm(dynamic value){
    isDescriptionFormValid = value.toString().isNotEmpty;
    isFormValid = isImageReady && isDescriptionFormValid;
    notifyListeners();
  }

  void setLatLangLocation(LatLng value) async{
    currentLocation = value;
    var placeMarks = await geo.placemarkFromCoordinates(
      currentLocation!.latitude,
      currentLocation!.longitude
    );

    placeMark = placeMarks.isNotEmpty ? placeMarks[0] : null;
    notifyListeners();
  }

  Future<bool> uploadStory({required BuildContext context}) async{
    try{
      if(isFormValid){
        isLoading = true;
        notifyListeners();

        double? latitude;
        double? longitude;
        if(currentLocation != null){
          latitude = currentLocation!.latitude;
          longitude = currentLocation!.longitude;
        }

        await storyService.uploadStory(
          file: File(file!.path),
          description: descriptionController.text,
          longitude: longitude,
          latitude: latitude
        );

        isLoading = false;
        notifyListeners();

        file = XFile("");
        descriptionController.clear();

        currentLocation = null;
        placeMark = null;

        isImageReady = false;
        isDescriptionFormValid = false;
        isFormValid = false;

        return true;
      }else{
        showSnackBar(
          context: context,
          text: AppLocalizations.of(context)!.storyFormValidation,
          backgroundColor: errorColor
        );
      }
      return false;
    }catch(e){
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}