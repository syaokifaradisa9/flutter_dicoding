import 'package:ditonton/data/models/production_country_model.dart';
import 'package:ditonton/domain/entities/production_country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProductionCountryModel = ProductionCountryModel(
    name: 'name',
    code: 'code'
  );

  final tProductionCountry= ProductionCountry(
      name: 'name',
      code: 'code'
  );

  test('should be a subclass of ProductionCountry entity', () async {
    final result = tProductionCountryModel.toEntity();
    expect(result, tProductionCountry);
  });
}
