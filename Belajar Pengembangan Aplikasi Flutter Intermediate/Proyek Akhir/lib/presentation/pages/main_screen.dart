import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/presentation/widgets/story_card.dart';
import 'package:story_app/providers/story_provider.dart';

class MainScreen extends StatelessWidget {
  final Function onTapStoryCard;
  final VoidCallback onTapAddStory;
  final VoidCallback onLogout;

  const MainScreen({
    required this.onTapStoryCard,
    required this.onTapAddStory,
    required this.onLogout,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Widget networkUnavailable({required VoidCallback onRefresh}){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi,
              color: Colors.black26
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.networkUnavailable,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.black26
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRefresh,
              child: Text(
                AppLocalizations.of(context)!.refreshStoryTextButton,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: primaryColor
                ),
              )
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffEDEDED),
      appBar: AppBar(
        leading: Transform.flip(
          flipX: true,
          child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: onLogout
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              AppSettings.openAppSettings(
                type: AppSettingsType.device,
                asAnotherTask: true
              );
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            )
          )
        ],
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Dicostory",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: secondaryColor
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: onTapAddStory,
        child: const Icon(Icons.camera_alt_rounded, color: Colors.white)
      ),
      body: Consumer<StoryProvider>(
        builder: (context, provider, _){
          if(provider.isLoading){
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if(provider.isError){
            return networkUnavailable(
              onRefresh: (){
                provider.refreshStory();
              }
            );
          }

          return ListView.builder(
            controller: provider.scrollController,
            itemCount: provider.stories.length + (provider.isLast ? 0 : 1),
            itemBuilder: (context, index){
              if((index == provider.stories.length) && !provider.isLast){
                if(provider.isLastError){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: networkUnavailable(
                      onRefresh: (){
                        provider.appendStory();
                      }
                    ),
                  );
                }

                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                );
              }

              return StoryCard(
                storyId: provider.stories[index].id,
                index: index,
                username: provider.stories[index].name,
                photoUrl: provider.stories[index].photoUrl,
                description: provider.stories[index].description,
                onTap: (){
                  onTapStoryCard(provider.stories[index].id);
                }
              );
            }
          );
        }
      ),
    );
  }
}
