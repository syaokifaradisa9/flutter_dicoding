import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 14
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

    Widget content({required Story story}){
      return Container(
        color: Colors.white,
        width: isMobile ? double.infinity : maxWidth,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Hero(
                      tag: 1,
                      child: CachedNetworkImage(
                          width: isMobile ? double.infinity : maxWidth,
                          fit: BoxFit.fitWidth,
                          imageUrl: story.photoUrl!,
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
                                "image-${story.id}",
                                stalePeriod: const Duration(days: 7),
                              )
                          )
                      )
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: onBack,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffEDEDED).withOpacity(0.6),
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    Padding(
                        padding: const EdgeInsets.only(left: 12, right: 16),
                        child: informationDetail(
                          icon: Icons.account_circle_rounded,
                          iconColor: primaryColor,
                          title: AppLocalizations.of(context)!.usernameLabel,
                          value: story.name
                        ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                        padding: const EdgeInsets.only(left: 12, right: 16),
                        child: informationDetail(
                            icon: Icons.date_range_rounded,
                            iconColor: primaryColor,
                            title: AppLocalizations.of(context)!.dateUploadLabel,
                            value: DateFormat('dd-MM-yyyy').format(
                              DateTime.parse(story.createAt!)
                            ),
                        ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 16),
                      child: informationDetail(
                        icon: Icons.timer_sharp,
                        iconColor: primaryColor,
                        title: AppLocalizations.of(context)!.timeUploadLabel,
                        value: DateFormat('hh:mm').format(
                          DateTime.parse(story.createAt!)
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 16),
                      child: informationDetail(
                        icon: Icons.document_scanner_sharp,
                        iconColor: primaryColor,
                        title: AppLocalizations.of(context)!.descriptionLabel,
                        value: story.description
                      ),
                    ),
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
          child: CircularProgressIndicator(color: primaryColor),
        ) : !isMobile ? Center(
          child: content(story: provider.story)
        ) : content(story: provider.story),
      ),
    );
  }
}
