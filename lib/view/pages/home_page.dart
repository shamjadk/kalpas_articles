import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalpas_news_app/controller/navigator_controller.dart';
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
            child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                      onTap: () =>
                          navPush(context, const NewsDescriptionPage()),
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
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('description'),
                                  Text(
                                    '📆 Date and time',
                                    style: TextStyle(
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
                separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                itemCount: 5),
          ),
        ),
      ),
    );
  }
}
