import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/genre_model.dart';
import 'package:movies/data/models/movie_detail_model.dart';
import 'package:movies/domain/entities/movie_detail.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'Action',
  );

  const tGenreModels = [tGenreModel];

  const tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 100000000,
    genres: tGenreModels,
    homepage: 'https://example.com',
    id: 1,
    imdbId: 'tt1234567',
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Movie overview',
    popularity: 7.5,
    posterPath: 'posterPath',
    releaseDate: '2023-08-15',
    revenue: 200000000,
    runtime: 120,
    status: 'Released',
    tagline: 'Movie tagline',
    title: 'Movie Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  const another1tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 100000000,
    genres: tGenreModels,
    homepage: 'https://example.com',
    id: 1,
    imdbId: 'tt1234567',
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Movie overview',
    popularity: 7.5,
    posterPath: 'posterPath',
    releaseDate: '2023-08-15',
    revenue: 200000000,
    runtime: 120,
    status: 'Released',
    tagline: 'Movie tagline',
    title: 'Movie Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  const another2tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 100000000,
    genres: tGenreModels,
    homepage: 'https://example.com',
    id: 2,
    imdbId: 'tt1234567',
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Movie overview',
    popularity: 7.5,
    posterPath: 'posterPath',
    releaseDate: '2023-08-15',
    revenue: 200000000,
    runtime: 120,
    status: 'Released',
    tagline: 'Movie tagline',
    title: 'Movie Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: tGenreModels.map((genre) => genre.toEntity()).toList(),
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Movie overview',
    posterPath: 'posterPath',
    releaseDate: '2023-08-15',
    runtime: 120,
    title: 'Movie Title',
    voteAverage: 8.0,
    voteCount: 1000,
  );

  final Map<String, dynamic> jsonMap = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'budget': 100000000,
    'genres': [
      {'id': 1, 'name': 'Action'},
    ],
    'homepage': 'https://example.com',
    'id': 1,
    'imdb_id': 'tt1234567',
    'original_language': 'en',
    'original_title': 'Original Title',
    'overview': 'Movie overview',
    'popularity': 7.5,
    'poster_path': 'posterPath',
    'release_date': '2023-08-15',
    'revenue': 200000000,
    'runtime': 120,
    'status': 'Released',
    'tagline': 'Movie tagline',
    'title': 'Movie Title',
    'video': false,
    'vote_average': 8.0,
    'vote_count': 1000,
  };

  test('should be a subclass of MovieDetail entity', () {
    final result = tMovieDetailResponse.toEntity();
    expect(result, tMovieDetail);
  });

  test('should convert from JSON correctly', () {
    final result = MovieDetailResponse.fromJson(jsonMap);
    expect(result, tMovieDetailResponse);
  });

  test('should convert to JSON correctly', () {
    final result = tMovieDetailResponse.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tMovieDetailResponse.props, another1tMovieDetailResponse.props);
  });

  test('should return false when props are not equal', () {
    expect(tMovieDetailResponse.props, isNot(another2tMovieDetailResponse.props));
  });
}