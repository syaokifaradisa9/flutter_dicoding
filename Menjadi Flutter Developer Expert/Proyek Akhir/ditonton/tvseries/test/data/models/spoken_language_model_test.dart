import 'package:tvseries/data/models/spoken_language_model.dart';
import 'package:tvseries/domain/entities/spoken_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSpokenLanguageModel = SpokenLanguageModel(
    name: 'name',
    code: 'code',
    englishName: 'englishName'
  );

  const tSpokenLanguage = SpokenLanguage(
      name: 'name',
      code: 'code',
      englishName: 'englishName'
  );

  const tSpokenLanguageAnother1 = SpokenLanguage(
      name: 'name',
      code: 'code',
      englishName: 'englishName'
  );

  const tSpokenLanguageAnother2 = SpokenLanguage(
      name: 'name',
      code: 'code2',
      englishName: 'englishName'
  );

  Map<String, dynamic> jsonMap = {
    'iso_639_1': 'code',
    'name': 'name',
    'english_name': 'englishName',
  };

  test('should be a subclass of SpokenLanguage entity', () async {
    final result = tSpokenLanguageModel.toEntity();
    expect(result, tSpokenLanguage);
  });

  test('should return a valid SpokenLanguageModel instance from JSON', () {
    final result = SpokenLanguageModel.fromJson(jsonMap);
    expect(result, tSpokenLanguageModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tSpokenLanguageModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tSpokenLanguage.props, tSpokenLanguageAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tSpokenLanguage.props, isNot(tSpokenLanguageAnother2.props));
  });
}
