import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalpas_news_app/controller/navigator_controller.dart';
import 'package:kalpas_news_app/controller/provider/api_provider.dart';
import 'package:kalpas_news_app/view/pages/news_description_page.dart';
import 'package:kalpas_news_app/view/widgets/tab_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            title: TabBar(
                onTap: (value) {
                  selectedTabIndex.value = value;
                  log('tab index = ${selectedTabIndex.value}');
                },
                labelPadding: const EdgeInsets.all(16),
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                tabs: [
                  TabWidget(
                    icon: Icons.list,
                    iconColor: Colors.black,
                    text: 'News',
                    index: 0,
                    selectedIndex: selectedTabIndex.value,
                  ),
                  TabWidget(
                    icon: Icons.favorite,
                    iconColor: Colors.red,
                    text: 'Favs',
                    index: 1,
                    selectedIndex: selectedTabIndex.value,
                  )
                ]),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
                future: ref.read(fetchDataProvider.future),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          InkWell(
                            onTap: () => navPush(context,
                                NewsDescriptionPage(model: data[index])),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: NetworkImage(data[index]
                                                      .urlToImage ??
                                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaUob4SHHVNhRBH-S7vhnPP8C6FLtbuyrwGVsUeXw1BPXqCHalzzqJ5XgVvVZ939LTkq4&usqp=CAU'),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  2 /
                                                  3.7,
                                          child: Text(
                                            data[index].title,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  2 /
                                                  3.7,
                                          child: Text(
                                            data[index].description ??
                                                'No description',
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        Text(
                                          '📆 ${data[index].publishedAt}',
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
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text('null'),
                    );
                  } else {
                    return const Text('error');
                  }
                }),
          ),
        ),
      ),
    );
  }
}
