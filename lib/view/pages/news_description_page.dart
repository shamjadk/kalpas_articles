import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalpas_news_app/controller/provider/api_provider.dart';
import 'package:kalpas_news_app/core/objectbox/favs_objectbox_store.dart';
import 'package:kalpas_news_app/model/news_model.dart';
import 'package:kalpas_news_app/model/objectbox/favs_entity_model.dart';
import 'package:kalpas_news_app/objectbox.g.dart';

class NewsDescriptionPage extends ConsumerWidget {
  final bool isFav;
  final NewsModel? model;
  final FavsEntityModel? favModel;
  const NewsDescriptionPage(
      {super.key,
      required this.model,
      required this.isFav,
      required this.favModel});

  Future<bool> checkExistance(Box<FavsEntityModel> box, String title) async {
    Query<FavsEntityModel> queries =
        box.query(FavsEntityModel_.title.equals(title)).build();

    int resultCount = queries.count();
    return resultCount > 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = FavsObjectBoxStore.instance.favBox;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
        titleSpacing: 0,
        title: const Text(
          'Back',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
              future:
                  checkExistance(box, isFav ? favModel!.title : model!.title),
              builder: (context, snapshot) {
                bool isStored = snapshot.data ?? false;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(isFav
                                  ? favModel!.urlToImage
                                  : model!.urlToImage ??
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaUob4SHHVNhRBH-S7vhnPP8C6FLtbuyrwGVsUeXw1BPXqCHalzzqJ5XgVvVZ939LTkq4&usqp=CAU'),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {},
                            icon: InkWell(
                              onTap: () {
                                ref
                                    .read(newsProvider.notifier)
                                    .removeFromFav(favModel!.id, context);
                              },
                              child: isStored
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : InkWell(
                                      onTap: () {
                                        ref.read(newsProvider.notifier).addFavs(
                                            FavsEntityModel(
                                                author: model!.author ??
                                                    'No author',
                                                title: model!.title,
                                                description:
                                                    model!.description ??
                                                        'No description',
                                                urlToImage: model!.urlToImage ??
                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaUob4SHHVNhRBH-S7vhnPP8C6FLtbuyrwGVsUeXw1BPXqCHalzzqJ5XgVvVZ939LTkq4&usqp=CAU',
                                                publishedAt: model!.publishedAt,
                                                content: model!.content),
                                            context);
                                      },
                                      child: const Icon(
                                        Icons.favorite_outline,
                                        color: Colors.black,
                                      ),
                                    ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      isFav ? favModel!.title : model!.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '📆 ${isFav ? favModel!.publishedAt : model!.publishedAt}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(isFav ? favModel!.content : model!.content),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
