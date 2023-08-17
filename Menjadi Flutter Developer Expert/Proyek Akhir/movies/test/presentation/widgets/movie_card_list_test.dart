import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('MovieCard displays movie title and overview', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(tMovie),
        ),
      ),
    );

    // Expect movie title and overview to be displayed
    expect(find.text('title'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
  });

  testWidgets('MovieCard navigates to movie detail on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(tMovie),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == movieDetailRoute) {
            return MaterialPageRoute(
              builder: (context) => const SizedBox(), // Mock movie detail page
            );
          }
        },
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Expect navigation to movie detail page
    expect(find.byType(SizedBox), findsOneWidget); // Replace with your actual movie detail widget type
  });

  testWidgets('MovieCard displays cached network image', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(tMovie),
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
          body: MovieCard(tMovie),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
