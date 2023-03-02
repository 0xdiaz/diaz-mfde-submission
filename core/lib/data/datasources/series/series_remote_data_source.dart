import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/models/series/season_detail_model.dart';
import 'package:core/data/models/series/series_detail_model.dart';
import 'package:core/data/models/series/series_model.dart';
import 'package:core/data/models/series/series_response.dart';
import 'package:http/http.dart' as http;

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getNowPlayingSeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<List<SeriesModel>> getTopRatedSeries();
  Future<SeriesDetailResponse> getSeriesDetail(int id);
  Future<List<SeriesModel>> getSeriesRecommendations(int id);
  Future<List<SeriesModel>> searchSeries(String query);
  Future<SeasonDetailResponse> getSeasonDetail(int id, int seasonNumber);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  SeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SeriesModel>> getNowPlayingSeries() async {
    final response =
    await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetailResponse> getSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return SeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailResponse> getSeasonDetail(int id, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$apiKey'));

    if (response.statusCode == 200) {
      return SeasonDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
