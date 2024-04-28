// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'news_model.g.dart';
part 'news_model.freezed.dart';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    @JsonKey(name: "source") required Source source,
    @JsonKey(name: "author") required dynamic author,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "description") required dynamic description,
    @JsonKey(name: "url") required String url,
    @JsonKey(name: "urlToImage") required dynamic urlToImage,
    @JsonKey(name: "publishedAt") required DateTime publishedAt,
    @JsonKey(name: "content") required String content,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}

@freezed
class Source with _$Source {
  const factory Source({
    @JsonKey(name: "id") required dynamic id,
    @JsonKey(name: "name") required String name,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
