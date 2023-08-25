import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

class FakePopularMovieState extends Fake implements PopularMovieState{}
class FakePopularMovieEvent extends Fake implements PopularMovieEvent{}

void main(){
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUpAll((){
    mockPopularMovieBloc = MockPopularMovieBloc();
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => mockPopularMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieLoading());
    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(
        const PopularMovieError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(
        PopularMovieHasData(testMovieList)
    );

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should show empty text when has no data', (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(
        PopularMovieEmpty()
    );

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byKey(const Key('empty-text')), findsOneWidget);
  });
}