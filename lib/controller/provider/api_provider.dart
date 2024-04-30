import 'package:kalpas_news_app/controller/api_service.dart';
import 'package:kalpas_news_app/model/news_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
Future<List<NewsModel>?> fetchData(FetchDataRef ref)async {
  return ApiService.fetchData();
}