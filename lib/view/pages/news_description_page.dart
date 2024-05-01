import 'package:flutter/material.dart';
import 'package:kalpas_news_app/controller/navigator_controller.dart';
import 'package:kalpas_news_app/model/news_model.dart';
import 'package:kalpas_news_app/model/objectbox/favs_entity_model.dart';
import 'package:kalpas_news_app/view/pages/demo_page.dart';

class NewsDescriptionPage extends StatelessWidget {
  final bool isFav;
  final NewsModel? model;
  final FavsEntityModel? favModel;
  const NewsDescriptionPage(
      {super.key,
      required this.model,
      required this.isFav,
      required this.favModel});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => navPush(
                    context,
                    const SwipeableContainer(
                      item: 'sss',
                    )),
                child: Container(
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
                        icon: const Icon(
                          Icons.favorite_outline,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                isFav ? favModel!.title : model!.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
          ),
        ),
      ),
    );
  }
}
