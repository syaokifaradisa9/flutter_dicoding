import 'package:flutter/material.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/services/story_service.dart';

class DetailStoryProvider with ChangeNotifier{
  StoryService storyService;
  DetailStoryProvider({required this.storyService});

  late Story story;
  bool isLoading = false;

  void getData(id) async{
    isLoading = true;
    notifyListeners();

    story = await storyService.getDetail(id: id);

    isLoading = false;
    notifyListeners();
  }
}