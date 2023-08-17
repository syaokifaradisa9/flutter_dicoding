import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/now_playing/now_playing_tv_series_bloc.dart';
import 'package:tvseries/presentation/bloc/top_rated/top_rated_tv_series_bloc.dart';
import 'package:tvseries/presentation/pages/now_playing_tv_series_page.dart';
import 'package:tvseries/presentation/pages/top_rated_tv_series_page.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';
import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingTvSeriesBloc extends MockBloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState>
    implements NowPlayingTvSeriesBloc {}

class FakeNowPlayingTvSeriesState extends Fake implements NowPlayingTvSeriesState{}
class FakeNowPlayingTvSeriesEvent extends Fake implements NowPlayingTvSeriesEvent{}

void main(){
  late MockNowPlayingTvSeriesBloc mockNowPlayingTvSeriesBloc;

  setUpAll((){
    mockNowPlayingTvSeriesBloc = MockNowPlayingTvSeriesBloc();
    registerFallbackValue(FakeNowPlayingTvSeriesEvent());
    registerFallbackValue(FakeNowPlayingTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesBloc>(
      create: (_) => mockNowPlayingTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state).thenReturn(NowPlayingTvSeriesLoading());
    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state).thenReturn(
      const NowPlayingTvSeriesError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state).thenReturn(
      NowPlayingHasData(testTvSeriesList)
    );

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvSeriesCard), findsOneWidget);
  });
}