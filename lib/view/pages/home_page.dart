import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: TabBar(
              onTap: (value) {},
              labelPadding: const EdgeInsets.all(16),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabs: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.list), Text('  News')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Text('  Favs')
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
