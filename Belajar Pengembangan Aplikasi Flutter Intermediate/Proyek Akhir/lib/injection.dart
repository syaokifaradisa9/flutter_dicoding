import 'package:get_it/get_it.dart';
import 'package:story_app/providers/add_story_provider.dart';
import 'package:story_app/providers/detail_story_provider.dart';
import 'package:story_app/providers/google_map_provider.dart';
import 'package:story_app/providers/login_provider.dart';
import 'package:story_app/providers/story_provider.dart';
import 'package:story_app/providers/register_provider.dart';
import 'package:story_app/services/auth_service.dart';
import 'package:story_app/services/local_storage_service.dart';
import 'package:story_app/services/story_service.dart';

final locator = GetIt.instance;

void init(){
  locator.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService()
  );

  locator.registerLazySingleton<AuthService>(
    () => AuthService(localStorageService: locator())
  );

  locator.registerLazySingleton<StoryService>(
    () => StoryService(localStorageService: locator())
  );

  locator.registerFactory<LoginProvider>(
    () => LoginProvider(authService: locator())
  );

  locator.registerFactory<RegisterProvider>(
    () => RegisterProvider(authService: locator())
  );

  locator.registerFactory<AddStoryProvider>(
    () => AddStoryProvider(storyService: locator())
  );

  locator.registerFactory<StoryProvider>(
    () => StoryProvider(storyService: locator())
  );

  locator.registerFactory<DetailStoryProvider>(
    () => DetailStoryProvider(storyService: locator())
  );

  locator.registerFactory<GoogleMapProvider>(
    () => GoogleMapProvider()
  );
}