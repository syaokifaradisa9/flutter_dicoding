import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/alert.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/presentation/pages/add_story_screen.dart';
import 'package:story_app/presentation/pages/detail_story_screen.dart';
import 'package:story_app/presentation/pages/login_screen.dart';
import 'package:story_app/presentation/pages/main_screen.dart';
import 'package:story_app/presentation/pages/register_screen.dart';
import 'package:story_app/presentation/pages/splash_screen.dart';
import 'package:story_app/providers/add_story_provider.dart';
import 'package:story_app/providers/detail_story_provider.dart';
import 'package:story_app/providers/login_provider.dart';
import 'package:story_app/providers/register_provider.dart';
import 'package:story_app/providers/story_provider.dart';
import 'package:story_app/services/local_storage_service.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin{
  final GlobalKey<NavigatorState> _navigatorKey;

  List<Page> historyStack = [];
  String? storyId;
  bool? isLoggedIn;

  bool isRegister = false;
  bool isAddStory = false;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>(){
    _init();
  }

  _init() async{
    LocalStorageService localStorageService = LocalStorageService();
    isLoggedIn = await localStorageService.isLoggedIn();
    notifyListeners();
  }

  List<Page> get _splashStack => const [
    MaterialPage(
      key: ValueKey("SplashScreen"),
      child: SplashScreen()
    )
  ];

  List<Page> loggedOutStack({required BuildContext context}) => [
    MaterialPage(
      key: const ValueKey("LoginScreen"),
      child: LoginScreen(
        onLogin: () async {
          bool isSuccess = await context.read<LoginProvider>().login(
            context: context
          );

          if(isSuccess && context.mounted){
            showSnackBar(
              context: context,
              text: AppLocalizations.of(context)!.loginSuccess
            );
            isLoggedIn = true;
            notifyListeners();
          }
        },
        onRegister: (){
          isRegister = true;
          notifyListeners();
        },
      )
    ),
    if(isRegister)
      MaterialPage(
        key: const ValueKey("RegisterScreen"),
        child: RegisterScreen(
          onRegister: () async{
            bool isSuccess = await context.read<RegisterProvider>().register(
              context: context
            );

            if(isSuccess && context.mounted){
              showSnackBar(
                context: context,
                text: AppLocalizations.of(context)!.registerSuccess
              );
              isRegister = false;
              notifyListeners();
            }
          },
          onLogin: (){
            isRegister = false;
            notifyListeners();
          },
        )
      )
  ];

  List<Page> loggedInStack({required BuildContext context}) => [
    MaterialPage(
      key: const ValueKey("MainScreen"),
      child: MainScreen(
        onTapStoryCard: (id){
          context.read<DetailStoryProvider>().getData(id);
          storyId = id;
          notifyListeners();
        },
        onTapAddStory: (){
          isAddStory = true;
          notifyListeners();
        },
        onLogout: () async{
          LocalStorageService localStorageService = LocalStorageService();
          bool isDeleted = await localStorageService.deleteLoginState();

          if(isDeleted && context.mounted){
            isLoggedIn = false;
            notifyListeners();
          }
        }
      )
    ),
    if(storyId != null)
      MaterialPage(
        key: ValueKey(storyId),
        child: DetailStoryScreen(
          onBack: (){
            storyId = null;
            notifyListeners();
          },
          id: storyId!
        )
      ),
    if(isAddStory)
      MaterialPage(
        key: const ValueKey("AddStoryScreen"),
        child: AddStoryScreen(
          onUpload: () async{
            bool isSuccess = await context.read<AddStoryProvider>().uploadStory(
              context: context
            );

            if(isSuccess && context.mounted){
              isAddStory = false;
              showSnackBar(
                context: context,
                text: AppLocalizations.of(context)!.uploadStorySuccess
              );
              context.read<StoryProvider>().refreshStory();
              notifyListeners();
            }
          },
        ),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    if(isLoggedIn == null){
      historyStack = _splashStack;
    }else if(isLoggedIn == true){
      historyStack = loggedInStack(context: context);
    }else{
      historyStack = loggedOutStack(context: context);
    }

    return Navigator(
      key: _navigatorKey,
      pages: historyStack,
      onPopPage: (route, result){
        final didPop = route.didPop(result);
        if(!didPop){
          return false;
        }

        isRegister = false;
        isAddStory = false;
        storyId = null;
        notifyListeners();

        return true;
      }
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }

}