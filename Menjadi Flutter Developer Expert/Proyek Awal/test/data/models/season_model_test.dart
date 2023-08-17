import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
    name: 'name',
    id: 1,
    airDate: 'airDate',
    seasonNumber: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    episodeCount: 1
  );

  final tSeason = Season(
      name: 'name',
      id: 1,
      airDate: 'airDate',
      seasonNumber: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      episodeCount: 1
  );

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
