import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:story_app/config/values.dart';
import 'package:story_app/models/story.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/services/local_storage_service.dart';

class StoryService{
  final LocalStorageService localStorageService;
  StoryService({required this.localStorageService});

  Future<bool> uploadStory({
    required File file,
    required String description,
    double? latitude,
    double? longitude,
  }) async{
    try{
      final apiToken = await localStorageService.getUserToken();

      double fileSize = file.lengthSync() / (1024 * 1024);
      List<int> bytes = await FlutterImageCompress.compressWithList(
        file.readAsBytesSync(),
        quality: ((0.99/fileSize) * 100).toInt(),
      );

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

      if(latitude != null && longitude != null){
        fields['lat'] = latitude.toString();
        fields['lon'] = longitude.toString();
      }

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

  Future<List<Story>> getStory({required int page}) async{
    try{
      final apiToken = await localStorageService.getUserToken();

      final response = await http.get(
        Uri.parse("$baseApiUrl/stories?size=10&page=$page"),
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

      var responseBodyStory = jsonDecode(response.body)['story'];
      Story story = Story.fromMap(responseBodyStory);
      return story;
    }catch(e){
      return Future.error(e.toString());
    }
  }
}