import 'package:tvseries/data/models/production_company_model.dart';
import 'package:tvseries/domain/entities/production_company.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProductionCompanyModel = ProductionCompanyModel(
    name: 'name',
    country: 'country',
    logoPath: 'logoPath',
    id: 'id'
  );

  const tProductionCompany = ProductionCompany(
    name: 'name',
    country: 'country',
    logoPath: 'logoPath',
    id: 'id'
  );

  const tProductionCompanyAnother1 = ProductionCompany(
      name: 'name',
      country: 'country',
      logoPath: 'logoPath',
      id: 'id'
  );

  const tProductionCompanyAnother2 = ProductionCompany(
      name: 'name',
      country: 'country',
      logoPath: 'logoPath',
      id: 'id2'
  );

  Map<String, dynamic> jsonMap = {
    'id': 'id',
    'name': 'name',
    'logo_path': 'logoPath',
    'origin_country': 'country',
  };

  test('should be a subclass of ProductionCompany entity', () async {
    final result = tProductionCompanyModel.toEntity();
    expect(result, tProductionCompany);
  });

  test('should return a valid ProductionCompanyModel instance from JSON', () {
    final result = ProductionCompanyModel.fromJson(jsonMap);
    expect(result, tProductionCompanyModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tProductionCompanyModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tProductionCompany.props, tProductionCompanyAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tProductionCompany.props, isNot(tProductionCompanyAnother2.props));
  });
}
