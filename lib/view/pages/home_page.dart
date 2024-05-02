import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalpas_news_app/controller/provider/api_provider.dart';
import 'package:kalpas_news_app/view/widgets/news_card_widget.dart';
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
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: FutureBuilder(
                    future: ref.read(newsProvider.notifier).fetchData(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data!.length,
                              itemBuilder: (context, index) => NewsCardWidget(
                                model: data[index],
                                favModel: null,
                                isFav: false,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 8,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Align(
                            alignment: Alignment.topCenter,
                            child: LinearProgressIndicator());
                      } else if (snapshot.data == null) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Error'),
                              IconButton(
                                  onPressed: () {
                                    ref.invalidate(newsProvider);
                                  },
                                  icon: const Icon(Icons.refresh))
                            ],
                          ),
                        );
                      } else {
                        return const Text('Error');
                      }
                    }),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ref.watch(newsProvider)!.length,
                      itemBuilder: (context, index) {
                        final data = ref.watch(newsProvider);
                        return NewsCardWidget(
                          model: null,
                          isFav: true,
                          favModel: data![index],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
