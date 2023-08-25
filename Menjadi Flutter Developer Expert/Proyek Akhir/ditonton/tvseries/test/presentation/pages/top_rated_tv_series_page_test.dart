import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/top_rated/top_rated_tv_series_bloc.dart';
import 'package:tvseries/presentation/pages/top_rated_tv_series_page.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';
import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvSeriesBloc extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvSeriesState{}
class FakeTopRatedTvSeriesEvent extends Fake implements TopRatedTvSeriesEvent{}

void main(){
  late MockTopRatedTvSeriesBloc mockTopRatedTvSeriesBloc;

  setUpAll((){
    mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>(
      create: (_) => mockTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should show progress indicator when loading', (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(TopRatedTvSeriesLoading());
    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should show error text when error', (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
        const TopRatedTvSeriesError("Failed")
    );

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(find.byKey(const Key('error-text')), findsOneWidget);
  });

  testWidgets('Page should show data when loaded', (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
        TopRatedTvSeriesHasData(testTvSeriesList)
    );

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvSeriesCard), findsOneWidget);
  });
}