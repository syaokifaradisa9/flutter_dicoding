import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/genre_model.dart';
import 'package:tvseries/domain/entities/genre.dart';

void main() {
  const tGenreModel = GenreModel(
      name: 'name',
      id: 1
  );

  final tGenre = Genre(
      name: 'name',
      id: 1
  );

  final tGenreAnother1 = Genre(
      name: 'name',
      id: 1
  );

  final tGenreAnother2 = Genre(
      name: 'name',
      id: 2
  );

  Map<String, dynamic> jsonMap = {
    "id": 1,
    "name": "name",
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
    expect(tGenre.props, tGenreAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tGenre.props, isNot(tGenreAnother2.props));
  });
}
