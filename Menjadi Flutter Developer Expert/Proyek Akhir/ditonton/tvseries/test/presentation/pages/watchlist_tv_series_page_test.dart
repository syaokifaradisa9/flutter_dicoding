import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:tvseries/presentation/pages/watchlist_tv_series_page.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTvSeriesBloc extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class FakeWatchlistTvSeriesState extends Fake implements WatchlistTvSeriesState{}
class FakeWatchlistTvSeriesEvent extends Fake implements WatchlistTvSeriesEvent{}

void main(){
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;

  setUpAll((){
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();
    registerFallbackValue(FakeWatchlistTvSeriesState());
    registerFallbackValue(FakeWatchlistTvSeriesEvent());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvSeriesBloc>(
      create: (_) => mockWatchlistTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(WatchlistTvSeriesLoading());
    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(
      const WatchlistTvSeriesError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.text('Failed'), findsOneWidget);
    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(
      WatchlistTvSeriesHasData(testTvSeriesList)
    );

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvSeriesCard), findsOneWidget);
  });

  testWidgets('Page should show empty text when has no data', (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(
      WatchlistTvSeriesEmpty()
    );

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byKey(const Key('empty-text')), findsOneWidget);
    expect(find.text('Watchlist Tv Series Empty!'), findsOneWidget);
  });
}