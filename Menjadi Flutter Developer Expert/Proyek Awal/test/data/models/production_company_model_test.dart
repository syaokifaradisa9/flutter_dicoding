import 'package:ditonton/data/models/production_company_model.dart';
import 'package:ditonton/domain/entities/production_company.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProductionCompanyModel = ProductionCompanyModel(
    name: 'name',
    country: 'country',
    logoPath: 'logoPath',
    id: 'id'
  );

  final tProductionCompany = ProductionCompany(
    name: 'name',
    country: 'country',
    logoPath: 'logoPath',
    id: 'id'
  );

  test('should be a subclass of ProductionCompany entity', () async {
    final result = tProductionCompanyModel.toEntity();
    expect(result, tProductionCompany);
  });
}
