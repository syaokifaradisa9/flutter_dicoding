import 'package:ditonton/data/models/creator_model.dart';
import 'package:ditonton/domain/entities/creator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tCreatorModel = CreatorModel(
    name: 'name',
    id: 1,
    creditId: 'creditId',
    gender: 1,
    profilePath: 'profilePath'
  );

  final tCreator = Creator(
      name: 'name',
      id: 1,
      creditId: 'creditId',
      gender: 1,
      profilePath: 'profilePath'
  );

  test('should be a subclass of Creator entity', () async {
    final result = tCreatorModel.toEntity();
    expect(result, tCreator);
  });
}
