import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetail{
  final TvSeriesRepository repository;
  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id){
    return repository.getDetailTvSeries(id);
  }
}