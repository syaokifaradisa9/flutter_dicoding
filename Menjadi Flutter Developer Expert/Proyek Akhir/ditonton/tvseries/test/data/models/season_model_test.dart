import 'package:tvseries/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/domain/entities/season.dart';

void main() {
  const tSeasonModel = SeasonModel(
    name: 'name',
    id: 1,
    airDate: 'airDate',
    seasonNumber: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    episodeCount: 1
  );

  const tSeason = Season(
      name: 'name',
      id: 1,
      airDate: 'airDate',
      seasonNumber: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      episodeCount: 1
  );

  const tSeasonAnother1 = Season(
      name: 'name',
      id: 1,
      airDate: 'airDate',
      seasonNumber: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      episodeCount: 1
  );

  const tSeasonAnother2 = Season(
      name: 'name',
      id: 2,
      airDate: 'airDate',
      seasonNumber: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      episodeCount: 1
  );

  Map<String, dynamic> jsonMap = {
    'air_date': 'airDate',
    'episode_count': 1,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });

  test('should return a valid SeasonModel instance from JSON', () {
    final result = SeasonModel.fromJson(jsonMap);
    expect(result, tSeasonModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tSeasonModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tSeason.props, tSeasonAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tSeason.props, isNot(tSeasonAnother2.props));
  });
}
