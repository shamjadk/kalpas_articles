import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kalpas_news_app/core/utils/api_utils.dart';
import 'package:kalpas_news_app/model/news_model.dart';

class ApiService {
  static Future<List<NewsModel>?> fetchData() async {
    final dio = Dio();
    try {
      final response = await dio.get(ApiUtils.url);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        final articles = <NewsModel>[];
        final data = response.data;
        for (final result in data['articles']) {
          articles.add(NewsModel.fromJson(result));
        }
        return articles;
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
