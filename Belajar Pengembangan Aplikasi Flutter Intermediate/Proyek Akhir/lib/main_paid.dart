import 'package:flutter/material.dart';
import 'package:story_app/flavors/flavor_config.dart';
import 'package:story_app/my_app.dart';
import 'injection.dart' as di;

void main() {
  FlavorConfig(
    flavorType: FlavorType.paid,
    canSetLocation: true
  );

  di.init();
  runApp(const MyApp());
}