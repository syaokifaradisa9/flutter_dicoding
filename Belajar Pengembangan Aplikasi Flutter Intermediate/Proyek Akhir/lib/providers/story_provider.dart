import 'package:flutter/material.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/services/story_service.dart';

class StoryProvider extends ChangeNotifier{
  late final StoryService storyService;
  late final ScrollController scrollController;

  bool isLoading = true;
  bool isError = false;
  bool isLastError = false;
  bool isLast = false;

  List<Story> stories = [];
  int currentPage = 1;

  StoryProvider({required this.storyService}){
    initialScrollController();
    refreshStory();
  }

  Future<void> appendStory() async{
    isLastError = false;
    if(!isLast){
      currentPage++;
      try{
        List<Story> newStories = await storyService.getStory(page: currentPage);
        if(newStories.length < 10){
          isLast = true;
        }

        stories.addAll(newStories);
      }catch(e){
        isLast = false;
        currentPage--;
        isLastError = true;
      }

      notifyListeners();
    }
  }

  initialScrollController(){
    scrollController = ScrollController();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
        appendStory();
      }
    });
  }

  Future<void> refreshStory() async{
    isLoading = true;
    isError = false;
    notifyListeners();

    try{
      stories = await storyService.getStory(page: currentPage);
      isError = false;
    }catch(e){
      isError = true;
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}