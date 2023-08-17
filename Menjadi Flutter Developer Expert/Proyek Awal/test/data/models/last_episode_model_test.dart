import 'package:ditonton/data/models/last_episode_model.dart';
import 'package:ditonton/domain/entities/last_episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tLastEpisodeModel = LastEpisodeModel(
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

  final tLastEpisode = LastEpisode(
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

  test('should be a subclass of LastEpisode entity', () async {
    final result = tLastEpisodeModel.toEntity();
    expect(result, tLastEpisode);
  });
}
