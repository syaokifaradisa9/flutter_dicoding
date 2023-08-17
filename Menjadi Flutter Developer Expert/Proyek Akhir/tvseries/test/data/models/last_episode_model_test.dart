import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/last_episode_model.dart';
import 'package:tvseries/domain/entities/last_episode.dart';

void main() {
  const tLastEpisodeModel = LastEpisodeModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    stillPath: 'stillPath',
    seasonNumber: 1,
    productionCode: "productionCode",
    episodeNumber: 1,
    airDate: 'airDate'
  );

  const tLastEpisode = LastEpisode(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    stillPath: 'stillPath',
    seasonNumber: 1,
    productionCode: "productionCode",
    episodeNumber: 1,
    airDate: 'airDate'
  );

  const tLastEpisodeAnother1 = LastEpisode(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1,
      voteCount: 1,
      stillPath: 'stillPath',
      seasonNumber: 1,
      productionCode: "productionCode",
      episodeNumber: 1,
      airDate: 'airDate'
  );

  const tLastEpisodeAnother2 = LastEpisode(
    id: 2,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    stillPath: 'stillPath',
    seasonNumber: 1,
    productionCode: "productionCode",
    episodeNumber: 1,
    airDate: 'airDate'
  );

  Map<String, dynamic> jsonMap = {
    'id': 1,
    'air_date': 'airDate',
    'episode_number': 1,
    'name': 'name',
    'overview': 'overview',
    'production_code': "productionCode",
    'season_number': 1,
    'still_path': 'stillPath',
    'vote_average': 1,
    'vote_count': 1,
  };

  test('should be a subclass of LastEpisode entity', () async {
    final result = tLastEpisodeModel.toEntity();
    expect(result, tLastEpisode);
  });

  test('should return a valid LastEpisodeModel instance from JSON', () {
    final result = LastEpisodeModel.fromJson(jsonMap);
    expect(result, tLastEpisodeModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tLastEpisodeModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tLastEpisode.props, tLastEpisodeAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tLastEpisode.props, isNot(tLastEpisodeAnother2.props));
  });
}
