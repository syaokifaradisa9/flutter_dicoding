import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  testWidgets('TvSeriesCard displays tv name and overview', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvSeriesCard(testTvSeries),
        ),
      ),
    );

    // Expect movie title and overview to be displayed
    expect(find.text('name'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
  });

  testWidgets('TvSeriesCard navigates to tv series detail on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvSeriesCard(testTvSeries),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == tvDetailRoute) {
            return MaterialPageRoute(
              builder: (context) => const SizedBox(), // Mock movie detail page
            );
          }
        },
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('TvSeriesCard displays cached network image', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvSeriesCard(testTvSeries),
        ),
      ),
    );

    // Expect CachedNetworkImage to be displayed
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('MovieCard displays loading indicator for network image', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvSeriesCard(testTvSeries),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
