import 'package:kalpas_news_app/model/objectbox/favs_entity_model.dart';
import 'package:kalpas_news_app/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FavsObjectBoxStore {
  static FavsObjectBoxStore? _instance;
  final Store store;
  late final Box<FavsEntityModel> favBox;

  FavsObjectBoxStore._create(this.store) {
    favBox = store.box<FavsEntityModel>();
  }

  static FavsObjectBoxStore get instance {
    return _instance!;
  }

  static Future<void> create() async {
    if (_instance == null) {
      final docsDir = await getApplicationDocumentsDirectory();
      final store = await openStore(
        directory: path.join(docsDir.path, 'favs'),
      );
      _instance = FavsObjectBoxStore._create(store);
    }
  }
}
