import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/creator_model.dart';
import 'package:tvseries/domain/entities/creator.dart';

void main() {
  const tCreatorModel = CreatorModel(
    name: 'name',
    id: 1,
    creditId: 'creditId',
    gender: 1,
    profilePath: 'profilePath'
  );

  const tCreator = Creator(
      name: 'name',
      id: 1,
      creditId: 'creditId',
      gender: 1,
      profilePath: 'profilePath'
  );

  const tCreatorAnother1 = Creator(
      name: 'name',
      id: 1,
      creditId: 'creditId',
      gender: 1,
      profilePath: 'profilePath'
  );

  const tCreatorAnother2 = Creator(
      name: 'name',
      id: 2,
      creditId: 'creditId',
      gender: 1,
      profilePath: 'profilePath'
  );

  const Map<String, dynamic> jsonMap = {
    "id": 1,
    "credit_id": "creditId",
    "name": "name",
    "gender": 1,
    "profile_path": "profilePath"
  };

  test('should be a subclass of Creator entity', () async {
    final result = tCreatorModel.toEntity();
    expect(result, tCreator);
  });

  test('should return a valid CreatorModel instance from JSON', () {
    final result = CreatorModel.fromJson(jsonMap);
    expect(result, tCreatorModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tCreatorModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tCreatorModel.props, tCreatorAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tCreatorModel.props, isNot(tCreatorAnother2.props));
  });
}
