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
      return box.getAll().toSet().toList();
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
      showSnackBar(context, 'Added to favs', color: Colors.green);
    } catch (e) {
      log(e.toString());
      showSnackBar(context, 'An error occured, try again', color: Colors.red);
    }
  }

  Future<void> removeFromFav(int? id, BuildContext context) async {
    try {
      box.remove(id!);
      state = box.getAll();
      Navigator.pop(context);
      showSnackBar(context, 'Removed from favs', color: Colors.red);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> checkObjectboxExistance(Box<FavsEntityModel> box, String title) async {
    Query<FavsEntityModel> queries =
        box.query(FavsEntityModel_.title.equals(title)).build();

    int resultCount = queries.count();
    return resultCount > 0;
  }
}
