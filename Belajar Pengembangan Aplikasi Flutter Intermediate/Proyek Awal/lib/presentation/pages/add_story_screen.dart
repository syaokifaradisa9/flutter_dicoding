import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/config/values.dart';
import 'package:story_app/presentation/widgets/button.dart';
import 'package:story_app/providers/add_story_provider.dart';

class AddStoryScreen extends StatelessWidget {
  final VoidCallback onUpload;
  const AddStoryScreen({
    required this.onUpload,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Widget imageSourceButton({
      required IconData icon,
      required String text,
      required VoidCallback onTap
    }){
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: Theme.of(context).textTheme.bodySmall,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: primaryColor)
            ),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: primaryColor),
              const SizedBox(width: 6),
              Text(
                text,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: primaryColor
                )
              )
            ],
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Dicostory",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: secondaryColor
          )
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: isMobile ?
              MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Consumer<AddStoryProvider>(
                  builder: (context, prov, _) => prov.isImageReady ? Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Image.file(File(prov.file!.path))
                  ) : Container(
                    height: 230,
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: maxWidth),
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
                    decoration: const BoxDecoration(color: Color(0xffEDEDED)),
                    child: const Icon(
                      Icons.photo,
                      color: Color(0xff9E9E9E),
                      size: 30,
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: imageSourceButton(
                        icon: Icons.add_photo_alternate,
                        text: AppLocalizations.of(context)!.galleryButtonText,
                        onTap: Provider.of<AddStoryProvider>(
                          context, listen: false
                        ).getImageFromGallery
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: imageSourceButton(
                        icon: Icons.camera_alt,
                        text: AppLocalizations.of(context)!.cameraButtonText,
                        onTap: Provider.of<AddStoryProvider>(
                          context, listen: false
                        ).getImageFromCamera
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.descriptionLabel,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: primaryColor
                        )
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        cursorColor: primaryColor,
                        minLines: 4,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryColor
                        ),
                        onChanged: Provider.of<AddStoryProvider>(
                          context
                        ).onChangeDescriptionForm,
                        controller: Provider.of<AddStoryProvider>(
                          context
                        ).descriptionController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: AppLocalizations.of(context)!.descriptionLabel,
                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: primaryColor
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 0),
                child: Consumer<AddStoryProvider>(
                  builder: (ctx, provider, _) => !provider.isLoading ? Button(
                    buttonColor: primaryColor.withOpacity(
                      provider.isFormValid ? 1 : 0.8
                    ),
                    textColor: Colors.white,
                    icon: Icons.upload,
                    textLabel: "Upload",
                    onTap: onUpload
                  ) : const CircularProgressIndicator(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
