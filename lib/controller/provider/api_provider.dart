import 'package:kalpas_news_app/controller/api_service.dart';
import 'package:kalpas_news_app/core/objectbox/favs_objectbox_store.dart';
import 'package:kalpas_news_app/model/news_model.dart';
import 'package:kalpas_news_app/model/objectbox/favs_entity_model.dart';
import 'package:kalpas_news_app/objectbox.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
class News extends _$News {
  late final Box<FavsEntityModel> box;
  @override
  void build() {
    box = FavsObjectBoxStore.instance.favBox;
  }

  Future<List<NewsModel>?> fetchData() async {
    return ApiService.fetchData();
  }

  Future<void> addFavs(FavsEntityModel model) async {
    box.put(model);
  }

  List<FavsEntityModel> getFavs() {
    return box.getAll();
  }

  Future<void> removeFromFav(int id) async {
    box.remove(id);
  }
}
