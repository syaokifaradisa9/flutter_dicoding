import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/genre_model.dart';
import 'package:movies/domain/entities/genre.dart';

void main() {
  const tGenreModel = GenreModel(
    name: 'name',
    id: 1,
  );

  const another1TGenreModel = GenreModel(
    name: 'name',
    id: 1,
  );

  const another2TGenreModel = GenreModel(
    name: 'name',
    id: 2,
  );

  const tGenre = Genre(
    name: 'name',
    id: 1,
  );

  final Map<String, dynamic> jsonMap = {
    'name': 'name',
    'id': 1,
  };

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should return a valid GenreModel instance from JSON', () {
    final result = GenreModel.fromJson(jsonMap);
    expect(result, tGenreModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tGenreModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tGenreModel.props, another1TGenreModel.props);
  });

  test('should return false when props are not equal', () {
    expect(tGenreModel.props, isNot(another2TGenreModel.props));
  });
}
