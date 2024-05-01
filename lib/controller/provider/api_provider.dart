import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kalpas_news_app/controller/api_service.dart';
import 'package:kalpas_news_app/core/objectbox/favs_objectbox_store.dart';
import 'package:kalpas_news_app/core/utils/snack_bar_utils.dart';
import 'package:kalpas_news_app/model/news_model.dart';
import 'package:kalpas_news_app/model/objectbox/favs_entity_model.dart';
import 'package:kalpas_news_app/objectbox.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
class News extends _$News {
  late final Box<FavsEntityModel> box;
  @override
  List<FavsEntityModel>? build() {
    box = FavsObjectBoxStore.instance.favBox;
    try {
      return box.getAll();
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<NewsModel>?> fetchData() async {
    return ApiService.fetchData();
  }

  Future<void> addFavs(FavsEntityModel model, BuildContext context) async {
    try {
      box.put(model);
      state = box.getAll();
      showSnackBar(context, 'Added to favs');
    } catch (e) {
      log(e.toString());
      showSnackBar(context, 'An error occured, try again');
    }
  }

  Future<void> removeFromFav(int id) async {
    try {
      box.remove(id);
    } catch (e) {
      log(e.toString());
    }
  }
}
