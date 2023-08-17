import 'dart:convert';
import 'dart:io';
import 'package:story_app/config/values.dart';
import 'package:story_app/models/story.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/services/local_storage_service.dart';

class StoryService{
  final LocalStorageService localStorageService;
  StoryService({required this.localStorageService});

  Future<bool> uploadStory({
    required File file,
    required String description
  }) async{
    try{
      final apiToken = await localStorageService.getUserToken();
      final bytes = await file.readAsBytes();

      var request = http.MultipartRequest(
          "POST",
          Uri.parse("$baseApiUrl/stories"),
      );

      final multiPartFile = http.MultipartFile.fromBytes(
        "photo",
        bytes,
        filename: file.path.split("/").last
      );

      final Map<String, String> fields = {
        "description": description,
      };

      final Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        "Authorization": "Bearer $apiToken"
      };

      request.files.add(multiPartFile);
      request.fields.addAll(fields);
      request.headers.addAll(headers);

      final http.StreamedResponse streamedResponse = await request.send();
      final int statusCode = streamedResponse.statusCode;

      if(statusCode == 201){
        return true;
      }else{
        throw Exception("Upload File Error!");
      }
    }catch(e){
      return Future.error(e);
    }
  }

  Future<List<Story>> getAll() async{
    try{
      final apiToken = await localStorageService.getUserToken();

      final response = await http.get(
        Uri.parse("$baseApiUrl/stories"),
        headers: {
          'Authorization': "Bearer $apiToken"
        }
      );

      List<Story> stories = [];
      var body = jsonDecode(response.body);

      var listStory = body['listStory'] as List;
      for(int i=0 ; i < listStory.length; i++){
        stories.insert(i, Story.fromMap(listStory[i]));
      }

      return stories;
    }catch(e){
      return Future.error(e.toString());
    }
  }

  Future<Story> getDetail({required String id}) async{
    try{
      final apiToken = await localStorageService.getUserToken();
      final response = await http.get(
        Uri.parse("$baseApiUrl/stories/$id"),
          headers: {
            'Authorization': "Bearer $apiToken"
          }
      );

      Story story = Story.fromMap(jsonDecode(response.body)['story']);
      return story;
    }catch(e){
      return Future.error(e.toString());
    }
  }
}