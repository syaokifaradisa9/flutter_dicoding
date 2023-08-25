import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMovieBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState{}
class FakeWatchlistMovieEvent extends Fake implements WatchlistMovieEvent{}

void main(){
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUpAll((){
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>(
      create: (_) => mockWatchlistMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }
  
  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieLoading());
    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state).thenReturn(
        const WatchlistMovieError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.text('Failed'), findsOneWidget);
    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state).thenReturn(
        WatchlistMovieHasData(testMovieList)
    );

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should show empty text when has no data', (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      WatchlistMovieEmpty()
    );

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byKey(const Key('empty-text')), findsOneWidget);
    expect(find.text('Watchlist Movies Empty!'), findsOneWidget);
  });
}