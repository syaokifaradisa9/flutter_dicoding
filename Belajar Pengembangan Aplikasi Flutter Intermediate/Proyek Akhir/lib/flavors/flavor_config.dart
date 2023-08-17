import 'package:flutter/foundation.dart';

enum FlavorType{
  free,
  paid
}

class FlavorConfig{
  final FlavorType flavorType;
  final bool canSetLocation;

  static FlavorConfig? _instance;

  FlavorConfig({
    this.flavorType = FlavorType.free,
    this.canSetLocation = false
  }){
    _instance = this;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}

class FlutterModeConfig{
  static bool get isDebug => kDebugMode;
  static bool get isRelease => kReleaseMode;
  static bool get isProfile => kProfileMode;

  static String get flutterMode => isDebug
      ? "debug"
      : isRelease
      ? "release"
      : isProfile
      ? "profile"
      : "unknown";
}