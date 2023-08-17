import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/colors.dart';
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
        builder: (context, provider, _) => provider.isLoading ? const Center(
          child: CircularProgressIndicator(color: primaryColor),
        ) : ListView.builder(
          itemCount: provider.stories.length,
          itemBuilder: (context, index) => StoryCard(
            storyId: provider.stories[index].id,
            index: index,
            username: provider.stories[index].name,
            photoUrl: provider.stories[index].photoUrl,
            description: provider.stories[index].description,
            onTap: (){
              onTapStoryCard(provider.stories[index].id);
            }
          ),
        ),
      ),
    );
  }
}
