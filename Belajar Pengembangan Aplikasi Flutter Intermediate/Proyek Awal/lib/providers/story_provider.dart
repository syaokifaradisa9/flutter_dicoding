import 'package:flutter/material.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/services/story_service.dart';

class StoryProvider extends ChangeNotifier{
  late final StoryService storyService;
  StoryProvider({required this.storyService}){
    refreshStory();
  }

  bool isLoading = true;
  List<Story> stories = [];

  Future<void> refreshStory() async{
    isLoading = true;
    notifyListeners();

    stories = await storyService.getAll();

    isLoading = false;
    notifyListeners();
  }
}