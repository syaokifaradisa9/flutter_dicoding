import 'package:ditonton/data/models/spoken_language_model.dart';
import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSpokenLanguageModel= SpokenLanguageModel(
    name: 'name',
    code: 'code',
    englishName: 'englishName'
  );

  final tSpokenLanguage = SpokenLanguage(
      name: 'name',
      code: 'code',
      englishName: 'englishName'
  );

  test('should be a subclass of SpokenLanguage entity', () async {
    final result = tSpokenLanguageModel.toEntity();
    expect(result, tSpokenLanguage);
  });
}
