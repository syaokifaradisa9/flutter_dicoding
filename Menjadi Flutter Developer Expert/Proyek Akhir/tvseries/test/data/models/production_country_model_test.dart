import 'package:tvseries/data/models/production_country_model.dart';
import 'package:tvseries/domain/entities/production_country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProductionCountryModel = ProductionCountryModel(
    name: 'name',
    code: 'code'
  );

  const tProductionCountry= ProductionCountry(
      name: 'name',
      code: 'code'
  );

  const tProductionCountryAnother1 = ProductionCountry(
      name: 'name',
      code: 'code'
  );

  const tProductionCountryAnother2 = ProductionCountry(
      name: 'name',
      code: 'code1'
  );

  Map<String, dynamic> jsonMap = {
    'iso_3166_1': 'code',
    'name': 'name',
  };

  test('should be a subclass of ProductionCountry entity', () async {
    final result = tProductionCountryModel.toEntity();
    expect(result, tProductionCountry);
  });

  test('should return a valid ProductionCountryModel instance from JSON', () {
    final result = ProductionCountryModel.fromJson(jsonMap);
    expect(result, tProductionCountryModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tProductionCountryModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tProductionCountry.props, tProductionCountryAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tProductionCountry.props, isNot(tProductionCountryAnother2.props));
  });
}
