import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/search/search_tv_series_bloc.dart';
import 'package:tvseries/presentation/pages/search_tv_series_page.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchTvSeriesBloc extends MockBloc<SearchTvSeriesEvent, SearchTvSeriesState>
    implements SearchTvSeriesBloc {}

class FakeSearchTvSeriesState extends Fake implements SearchTvSeriesState{}
class FakeSearchTvSeriesEvent extends Fake implements SearchTvSeriesEvent{}

void main(){
  late MockSearchTvSeriesBloc mockSearchTvSeriesBloc;

  setUpAll((){
    mockSearchTvSeriesBloc = MockSearchTvSeriesBloc();
    registerFallbackValue(FakeSearchTvSeriesEvent());
    registerFallbackValue(FakeSearchTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvSeriesBloc>(
      create: (_) => mockSearchTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state).thenReturn(SearchTvSeriesLoading());
    await tester.pumpWidget(_makeTestableWidget(const SearchTvSeriesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state).thenReturn(
        const SearchTvSeriesError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const SearchTvSeriesPage()));
    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state).thenReturn(
        SearchTvSeriesHasData(testTvSeriesList)
    );

    await tester.pumpWidget(_makeTestableWidget(const SearchTvSeriesPage()));

    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvSeriesCard), findsOneWidget);
  });

  testWidgets('Page should show empty text when has no data', (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state).thenReturn(
      SearchTvSeriesEmpty()
    );

    await tester.pumpWidget(_makeTestableWidget(const SearchTvSeriesPage()));

    expect(find.byKey(const Key('empty-text')), findsOneWidget);
  });
}