import 'package:flutter/foundation.dart';

const baseApiUrl = "https://story-api.dicoding.dev/v1";
const double maxWidth = 500;

final bool isMobile = [
  TargetPlatform.android,
  TargetPlatform.iOS
].contains(defaultTargetPlatform);