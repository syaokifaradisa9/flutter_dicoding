import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/popular/popular_tv_series_bloc.dart';
import 'package:tvseries/presentation/pages/popular_tv_series_page.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTvSeriesBloc extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

class FakePopularTvSeriesState extends Fake implements PopularTvSeriesState{}
class FakePopularTvSeriesEvent extends Fake implements PopularTvSeriesEvent{}

void main(){
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;

  setUpAll((){
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>(
      create: (_) => mockPopularTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state).thenReturn(PopularTvSeriesLoading());
    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state).thenReturn(
        const PopularTvSeriesError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state).thenReturn(
        PopularTvSeriesHasData(testTvSeriesList)
    );

    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvSeriesCard), findsOneWidget);
  });

  testWidgets('Page should show empty text when has no data', (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state).thenReturn(
      PopularTvSeriesEmpty()
    );

    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byKey(const Key('empty-text')), findsOneWidget);
  });
}