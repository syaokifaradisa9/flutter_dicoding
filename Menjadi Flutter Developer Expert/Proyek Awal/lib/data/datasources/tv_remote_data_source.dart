import 'dart:convert';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getRecommendations(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource{
  final apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  final baseUrl = 'https://api.themoviedb.org/3';
  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));
    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/top_rated?$apiKey')
    );
    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/on_the_air?$apiKey')
    );

    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));
    if(response.statusCode == 200){
      return TvSeriesDetailResponse.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey')
    );

    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/search/tv?$apiKey&query=$query')
    );

    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }
}