import 'dart:convert';

import 'package:core/data/datasources/series/series_remote_data_source.dart';
import 'package:core/data/models/series/season_detail_model.dart';
import 'package:core/data/models/series/series_detail_model.dart';
import 'package:core/data/models/series/series_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../utils/test_constants.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Now Playing  Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/now_playing.json')))
        .seriesList;

    test('should return list of  Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular  Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/popular.json')))
        .seriesList;

    test('should return list of  Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/popular.json'), 200));
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated  Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/top_rated.json')))
        .seriesList;

    test('should return list of  Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search  Series', () {
    final tSearchResult = SeriesResponse.fromJson(json.decode(
      readJson('dummy_data/series/search_example_series.json'),
    )).seriesList;
    const tQuery = 'Game of Thrones';

    test('should return list of  series when response code is 200', () async {
      // arrange
      when(
        mockHttpClient
            .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')),
      ).thenAnswer(
        (_) async => http.Response(
            readJson('dummy_data/series/search_example_series.json'),
            200),
      );
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get  Series Detail', () {
    const tId = 1;
    final tSeriesDetail = SeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/series/series_detail.json')));

    test('should return  series detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/series_detail.json'), 200));
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get  Series Recommendations', () {
    final tMovieList = SeriesResponse.fromJson(json.decode(
            readJson('dummy_data/series/series_recommendations.json')))
        .seriesList;
    const tId = 1;

    test('should return list of  Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/series_recommendations.json'),
              200));
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Season Detail', () {
    const tId = 1;
    const tSeasonNumber = 1;
    final tSeasonDetail = SeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/series/season_detail.json')));

    test('should return season detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/season_detail.json'), 200));
      // act
      final result = await dataSource.getSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(result, equals(tSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
