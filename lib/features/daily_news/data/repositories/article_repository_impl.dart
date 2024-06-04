import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_application/core/constants/constants.dart';
import 'package:news_application/core/resources/data_state.dart';
import 'package:news_application/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_application/features/daily_news/domain/entities/article.dart';
import 'package:news_application/features/daily_news/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _mewsApiService;

  ArticleRepositoryImpl(this._mewsApiService);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await _mewsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        category: categoryQuery,
        country: countryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
