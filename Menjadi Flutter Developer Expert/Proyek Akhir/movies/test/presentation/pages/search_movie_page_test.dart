import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMovieBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

class FakeSearchMovieState extends Fake implements SearchMovieState{}
class FakeSearchMovieEvent extends Fake implements SearchMovieEvent{}

void main(){
  late MockSearchMovieBloc mockSearchMovieBloc;

  setUpAll((){
    mockSearchMovieBloc = MockSearchMovieBloc();
    registerFallbackValue(FakeSearchMovieEvent());
    registerFallbackValue(FakeSearchMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>(
      create: (_) => mockSearchMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMovieLoading());
    await tester.pumpWidget(_makeTestableWidget(const SearchMoviePage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(
      const SearchMovieError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const SearchMoviePage()));
    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(
      SearchMovieHasData(testMovieList)
    );

    await tester.pumpWidget(_makeTestableWidget(const SearchMoviePage()));

    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should show empty text when has no data', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(
      SearchMovieEmpty()
    );

    await tester.pumpWidget(_makeTestableWidget(const SearchMoviePage()));

    expect(find.byKey(const Key('empty-text')), findsOneWidget);
  });
}