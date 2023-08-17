import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/movies.dart';
import 'watchlist_movie_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListMovieStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist
])
void main(){
  late WatchlistMovieStatusBloc watchlistMovieStatusBloc;
  late MockGetWatchListMovieStatus mockGetWatchListMovieStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;

  setUp((){
    mockGetWatchListMovieStatus = MockGetWatchListMovieStatus();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();
    watchlistMovieStatusBloc = WatchlistMovieStatusBloc(
      mockSaveMovieWatchlist,
      mockRemoveMovieWatchlist,
      mockGetWatchListMovieStatus
    );
  });

  test('initial state should be empty', (){
    expect(watchlistMovieStatusBloc.state, WatchlistMovieStatusEmpty());
  });

  const tId = 1;
  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'should get watchlist status',
    build: (){
      when(mockGetWatchListMovieStatus.execute(tId)).thenAnswer(
        (_) async => true
      );
      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(const OnFetchWatchlistStatus(tId)),
    expect: () => [
      WatchlistMovieStatusLoading(),
      WatchlistMovieStatusHasData(
        isAdded: true,
        message: ''
      )
    ],
    verify: (bloc) => mockGetWatchListMovieStatus.execute(tId)
  );

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'should add movie to watchlist and update status',
    build: () {
      when(mockSaveMovieWatchlist.execute(any)).thenAnswer(
        (_) async => const Right('')
      );
      when(mockGetWatchListMovieStatus.execute(tId)).thenAnswer(
        (_) async => true
      );

      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(const OnAddedToWatchlist(MovieDetail(
      id: tId,
      adult: false,
      backdropPath: '',
      genres: [],
      originalTitle: '',
      overview: '',
      posterPath: '',
      releaseDate: '',
      runtime: 0,
      title: '',
      voteAverage: 0.0,
      voteCount: 0,
    ))),
    expect: () => [
      WatchlistMovieStatusLoading(),
      WatchlistMovieStatusHasData(
        isAdded: true,
        message: '',
      ),
    ],
    verify: (bloc) {
      verify(mockSaveMovieWatchlist.execute(any)).called(1);
      verify(mockGetWatchListMovieStatus.execute(tId)).called(1);
    },
  );

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'should emit WatchlistMovieStatusError when adding movie to watchlist fails',
    build: () {
      when(mockSaveMovieWatchlist.execute(any)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Error'))
      );
      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(const OnAddedToWatchlist(MovieDetail(
      id: tId,
      adult: false,
      backdropPath: '',
      genres: [],
      originalTitle: '',
      overview: '',
      posterPath: '',
      releaseDate: '',
      runtime: 0,
      title: '',
      voteAverage: 0.0,
      voteCount: 0,
    ))),
    expect: () => [
      WatchlistMovieStatusLoading(),
      const WatchlistMovieStatusError('Server Error'),
    ],
    verify: (bloc) {
      verify(mockSaveMovieWatchlist.execute(any)).called(1);
    },
  );

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'should remove movie from watchlist and update status',
    build: () {
      when(mockRemoveMovieWatchlist.execute(any)).thenAnswer(
        (_) async => const Right('')
      );
      when(mockGetWatchListMovieStatus.execute(tId)).thenAnswer(
        (_) async => false
      );

      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveFromWatchList(MovieDetail(
      id: tId,
      adult: false,
      backdropPath: '',
      genres: [],
      originalTitle: '',
      overview: '',
      posterPath: '',
      releaseDate: '',
      runtime: 0,
      title: '',
      voteAverage: 0.0,
      voteCount: 0,
    ))),
    expect: () => [
      WatchlistMovieStatusLoading(),
      WatchlistMovieStatusHasData(
        isAdded: false,
        message: '',
      ),
    ],
    verify: (bloc) {
      verify(mockRemoveMovieWatchlist.execute(any)).called(1);
      verify(mockGetWatchListMovieStatus.execute(tId)).called(1);
    },
  );

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'should emit WatchlistMovieStatusError when removing movie from watchlist fails',
    build: () {
      when(mockRemoveMovieWatchlist.execute(any)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Error'))
      );

      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveFromWatchList(MovieDetail(
      id: tId,
      adult: false,
      backdropPath: '',
      genres: [],
      originalTitle: '',
      overview: '',
      posterPath: '',
      releaseDate: '',
      runtime: 0,
      title: '',
      voteAverage: 0.0,
      voteCount: 0,
    ))),
    expect: () => [
      WatchlistMovieStatusLoading(),
      const WatchlistMovieStatusError('Server Error'),
    ],
    verify: (bloc) {
      verify(mockRemoveMovieWatchlist.execute(any)).called(1);
    },
  );

  group('WatchlistMovieStatusEvent', () {
    const tId = 1;
    const tMovieDetail = MovieDetail(
      id: tId,
      adult: false,
      backdropPath: '',
      genres: [],
      originalTitle: '',
      overview: '',
      posterPath: '',
      releaseDate: '',
      runtime: 0,
      title: '',
      voteAverage: 0.0,
      voteCount: 0,
    );

    test('OnFetchWatchlistStatus should have correct props', () {
      const event1 = OnFetchWatchlistStatus(tId);
      const event2 = OnFetchWatchlistStatus(tId);

      expect(event1.props, [tId]);
      expect(event2.props, [tId]);
      expect(event1, event2);
    });

    test('OnAddedToWatchlist should have correct props', () {
      const event1 = OnAddedToWatchlist(tMovieDetail);
      const event2 = OnAddedToWatchlist(tMovieDetail);

      expect(event1.props, [tMovieDetail]);
      expect(event2.props, [tMovieDetail]);
      expect(event1, event2);
    });

    test('OnRemoveFromWatchList should have correct props', () {
      const event1 = OnRemoveFromWatchList(tMovieDetail);
      const event2 = OnRemoveFromWatchList(tMovieDetail);

      expect(event1.props, [tMovieDetail]);
      expect(event2.props, [tMovieDetail]);
      expect(event1, event2);
    });
  });
}