import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBloc extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

class FakeTopRatedMovieState extends Fake implements TopRatedMovieState{}
class FakeTopRatedMovieEvent extends Fake implements TopRatedMovieEvent{}

void main(){
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUpAll((){
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (_) => mockTopRatedMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
      when(() => mockTopRatedMovieBloc.state).thenReturn(TopRatedMovieLoading());
      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockTopRatedMovieBloc.state).thenReturn(
      const TopRatedMovieError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockTopRatedMovieBloc.state).thenReturn(
      TopRatedMovieHasData(testMovieList)
    );

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });
}