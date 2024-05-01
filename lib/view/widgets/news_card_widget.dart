import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalpas_news_app/controller/navigator_controller.dart';
import 'package:kalpas_news_app/controller/provider/api_provider.dart';
import 'package:kalpas_news_app/model/news_model.dart';
import 'package:kalpas_news_app/model/objectbox/favs_entity_model.dart';
import 'package:kalpas_news_app/view/pages/news_description_page.dart';

class NewsCardWidget extends HookConsumerWidget {
  final bool isFav;
  final NewsModel? model;
  final FavsEntityModel? favModel;
  const NewsCardWidget({
    super.key,
    required this.model,
    required this.isFav,
    required this.favModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardPosition = useState<double>(0);
    return GestureDetector(
      onTap: () => navPush(
        context,
        NewsDescriptionPage(
          model: isFav ? null : model,
          favModel: isFav ? favModel : null,
          isFav: isFav,
        ),
      ),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              IconButton(
                  onPressed: () {
                    ref.read(newsProvider.notifier).addFavs(
                        FavsEntityModel(
                            author:
                                isFav ? favModel!.author : model!.author ?? '',
                            title: isFav ? favModel!.title : model!.title,
                            description: isFav
                                ? favModel!.description
                                : model!.description ?? '',
                            urlToImage: isFav
                                ? favModel!.urlToImage
                                : model!.urlToImage ??
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaUob4SHHVNhRBH-S7vhnPP8C6FLtbuyrwGVsUeXw1BPXqCHalzzqJ5XgVvVZ939LTkq4&usqp=CAU',
                            publishedAt: isFav
                                ? favModel!.publishedAt
                                : model!.publishedAt,
                            content:
                                isFav ? favModel!.content : model!.content),
                        context);
                  },
                  icon: const Icon(Icons.favorite))
            ],
          ),
        );
      },
      onHorizontalDragUpdate: (details) {
        cardPosition.value += details.delta.dx;
      },
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(isFav
                            ? favModel!.urlToImage
                            : model!.urlToImage ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaUob4SHHVNhRBH-S7vhnPP8C6FLtbuyrwGVsUeXw1BPXqCHalzzqJ5XgVvVZ939LTkq4&usqp=CAU'),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 2 / 3.7,
                    child: Text(
                      isFav ? favModel!.title : model!.title,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.sizeOf(context).width * 2 / 3.7,
                    child: Text(
                      isFav
                          ? favModel!.description
                          : model!.description ?? 'No description',
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Text(
                    '📆 ${isFav ? favModel!.publishedAt : model!.publishedAt}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
