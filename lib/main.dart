import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalpas_news_app/core/objectbox/favs_objectbox_store.dart';
import 'package:kalpas_news_app/view/pages/home_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavsObjectBoxStore.create();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
