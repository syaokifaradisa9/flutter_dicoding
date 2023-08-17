import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/config/values.dart';
import 'package:story_app/models/story.dart';
import 'package:story_app/providers/detail_story_provider.dart';

class DetailStoryScreen extends StatelessWidget {
  final VoidCallback onBack;
  final String id;
  const DetailStoryScreen({
    required this.onBack,
    required this.id,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Widget informationDetail({
      required IconData icon,
      required Color iconColor,
      required title,
      required value}
    ){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: iconColor
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 14
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      );
    }

    Widget storyImageValue({ required String storyId }){
      return SizedBox(
        height: 200,
        child: Stack(
          children: [
            Hero(
              tag: storyId,
              child: Consumer<DetailStoryProvider>(
                  builder: (context, provider, _) => CachedNetworkImage(
                      width: isMobile ? double.infinity : maxWidth,
                      fit: BoxFit.fitWidth,
                      imageUrl: provider.story.photoUrl,
                      progressIndicatorBuilder: (_, __, ___) => const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                      fadeInDuration: const Duration(seconds: 3),
                      errorWidget: (_, __, ___) => const SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                      cacheManager: CacheManager(
                          Config(
                            "image-${provider.story.id}",
                            stalePeriod: const Duration(days: 7),
                          )
                      )
                  )
              )
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: onBack,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffEDEDED).withOpacity(0.6),
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget storyUsernameValue({ required String name }){
      return TweenAnimationBuilder(
          tween: Tween(begin: 200.0, end: 12.0),
          duration: const Duration(milliseconds: 750),
          builder: (context, value, child) => Padding(
            padding: EdgeInsets.only(
              left: value,
              right: 16
            ),
            child: informationDetail(
              icon: Icons.account_circle_rounded,
              iconColor: primaryColor,
              title: AppLocalizations.of(context)!.usernameLabel,
              value: name
            )
          )
      );
    }

    Widget storyUploadDateValue({required String createdAt}){
      return TweenAnimationBuilder(
          tween: Tween(begin: 200.0, end: 12.0),
          duration: const Duration(milliseconds: 750),
          builder: (context, value, child) => Padding(
            padding: EdgeInsets.only(
              left: value,
              right: 16
            ),
            child: informationDetail(
              icon: Icons.date_range_rounded,
              iconColor: primaryColor,
              title: AppLocalizations.of(context)!.uploadDateLabel,
              value: DateFormat('dd-MM-yyyy').format(
                DateTime.parse(createdAt)
              ),
            )
          )
      );
    }

    Widget storyUploadTimeValue({ required String createdAt }){
      return TweenAnimationBuilder(
        tween: Tween(begin: 200.0, end: 12.0),
        duration: const Duration(milliseconds: 750),
        builder: (context, value, child) => Padding(
          padding: EdgeInsets.only(
            left: value,
            right: 16
          ),
          child: informationDetail(
            icon: Icons.timer_sharp,
            iconColor: primaryColor,
            title: AppLocalizations.of(context)!.uploadTimeLabel,
            value: DateFormat('hh:mm').format(
              DateTime.parse(createdAt)
            ),
          )
        )
      );
    }

    Widget storyDescriptionValue({ required String description }){
      return TweenAnimationBuilder(
        tween: Tween(begin: 200.0, end: 12.0),
        duration: const Duration(milliseconds: 750),
        builder: (context, value, child) => Padding(
          padding: EdgeInsets.only(
            left: value,
            right: 16
          ),
          child: informationDetail(
            icon: Icons.document_scanner_sharp,
            iconColor: primaryColor,
            title: AppLocalizations.of(context)!.photoDescriptionLabel,
            value: description
          )
        )
      );
    }

    Widget storyLocationValue(){
      return Consumer<DetailStoryProvider>(
        builder: (context, provider, _){
          if(provider.placeMark == null){
            return const SizedBox();
          }else{
            var placeMark = provider.placeMark!;
            return TweenAnimationBuilder(
              tween: Tween(begin: 200.0, end: 12.0),
              duration: const Duration(milliseconds: 750),
              builder: (context, value, child) => Padding(
                padding: EdgeInsets.only(
                  left: value,
                  right: 16
                ),
                child: Column(
                  children: [
                    SizedBox(height: provider.story.latitude != null ? 14 : 0),
                    informationDetail(
                      icon: Icons.location_pin,
                      iconColor: primaryColor,
                      title: AppLocalizations.of(context)!.locationLabel,
                      value: "${placeMark.street} "
                        "${placeMark.subLocality} "
                        "${placeMark.locality} "
                        "${placeMark.postalCode}"
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 26,
                        top: 4
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: GoogleMap(
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          markers: provider.markers,
                          initialCameraPosition: CameraPosition(
                            zoom: 18,
                            target: provider.currentLocation!
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      );
    }

    Widget content({ required Story story }){
      return Container(
        color: Colors.white,
        width: isMobile ? double.infinity : maxWidth,
        child: Column(
          children: [
            storyImageValue(storyId: story.id),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    storyUsernameValue(name: story.name),
                    const SizedBox(height: 14),
                    storyUploadDateValue(createdAt: story.createdAt),
                    const SizedBox(height: 14),
                    storyUploadTimeValue(createdAt: story.createdAt),
                    const SizedBox(height: 14),
                    storyDescriptionValue(description: story.description),
                    storyLocationValue()
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffEDEDED),
      body: Consumer<DetailStoryProvider>(
        builder: (context, provider, _) => provider.isLoading ? const Center(
          child: CircularProgressIndicator()
        ): !isMobile ? Center(child: content(
          story: provider.story
        )) : content(story: provider.story)
      )
    );
  }
}
