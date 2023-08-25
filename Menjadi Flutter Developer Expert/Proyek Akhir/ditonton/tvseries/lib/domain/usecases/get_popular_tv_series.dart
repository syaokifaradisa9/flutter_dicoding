import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetPopularTvSeries{
  final TvSeriesRepository repository;
  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(){
    return repository.getPopularTvSeries();
  }
}