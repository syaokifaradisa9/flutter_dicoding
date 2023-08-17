import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/movie_table.dart';
import 'package:movies/domain/entities/genre.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';

void main() {
  const tGenre = Genre(id: 1, name: 'Action');
  const tGenres = [tGenre];

  final Map<String, dynamic> map = {
    'id': 1,
    'title': 'Movie Title',
    'posterPath': 'posterPath',
    'overview': 'Movie overview',
  };

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: tGenres,
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

  final tMovie = Movie.watchlist(
    id: 1,
    overview: 'Movie overview',
    posterPath: 'posterPath',
    title: 'Movie Title',
  );

  const tMovieTable = MovieTable(
    id: 1,
    title: 'Movie Title',
    posterPath: 'posterPath',
    overview: 'Movie overview',
  );

  const another1tMovieTable = MovieTable(
    id: 1,
    title: 'Movie Title',
    posterPath: 'posterPath',
    overview: 'Movie overview',
  );

  const another2tMovieTable = MovieTable(
    id: 2,
    title: 'Movie Title',
    posterPath: 'posterPath',
    overview: 'Movie overview',
  );

  test('should create a MovieTable from an entity', () {
    final result = MovieTable.fromEntity(tMovieDetail);
    expect(result, tMovieTable);
  });

  test('should create a MovieTable from a map', () {

    final result = MovieTable.fromMap(map);
    expect(result, tMovieTable);
  });

  test('should convert to JSON correctly', () {
    final result = tMovieTable.toJson();
    expect(result, map);
  });

  test('should create a Movie entity from MovieTable', () {
    final result = tMovieTable.toEntity();
    expect(result, tMovie);
  });

  test('should return true when props are equal', () {
    expect(tMovieTable.props, another1tMovieTable.props);
  });

  test('should return false when props are not equal', () {
    expect(tMovieTable.props, isNot(another2tMovieTable.props));
  });
}