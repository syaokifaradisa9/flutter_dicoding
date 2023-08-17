import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:story_app/config/values.dart';
import '../../config/colors.dart';

class StoryCard extends StatelessWidget {
  final String? storyId;
  final String? username;
  final String? description;
  final int index;
  final String? photoUrl;
  final VoidCallback onTap;

  const StoryCard({
    this.storyId,
    required this.index,
    this.username,
    this.photoUrl,
    this.description,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(height: index == 0 ? 4 : 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: maxWidth,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: storyId.toString(),
                    child: CachedNetworkImage(
                      imageUrl: photoUrl!,
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
                          "cache-$storyId",
                          stalePeriod: const Duration(days: 7),
                        )
                      ),
                      imageBuilder: (_, image){
                        return Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)
                            ),
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.fitWidth
                            )
                          ),
                        );
                      }
                    )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                        bottom: 10,
                        right: 10,
                        left: 10
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username!,
                            style: Theme.of(context).textTheme.bodyLarge
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description!,
                            textAlign: TextAlign.justify,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 6)
                        ],
                      ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
