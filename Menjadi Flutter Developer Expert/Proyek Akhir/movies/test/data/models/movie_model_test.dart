import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/movie_model.dart';
import 'package:movies/domain/entities/movie.dart';

void main() {
  final Map<String, dynamic> jsonMap = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'genre_ids': [1, 2, 3],
    'id': 1,
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 1,
    'poster_path': 'posterPath',
    'release_date': 'releaseDate',
    'title': 'title',
    'video': false,
    'vote_average': 1,
    'vote_count': 1,
  };

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Movie entity', () {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should convert from JSON correctly', () {
    final result = MovieModel.fromJson(jsonMap);
    expect(result, tMovieModel);
  });

  test('should convert to JSON correctly', () {
    final result = tMovieModel.toJson();
    expect(result, jsonMap);
  });

  test('should have correct props', () {
    expect(tMovieModel.props, tMovie.props);
  });
}