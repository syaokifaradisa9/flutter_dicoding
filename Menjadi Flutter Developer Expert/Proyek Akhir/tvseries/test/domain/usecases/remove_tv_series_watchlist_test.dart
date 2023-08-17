import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/remove_tv_series_watchlist.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveTvSeriesWatchlist(mockTvSeriesRepository);
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchList(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.removeWatchList(testTvSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
