import 'package:flutter/material.dart';

class SwipeableList extends StatelessWidget {
  const SwipeableList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipeable List'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          return SwipeableContainer(item: 'item $index');
        },
      ),
    );
  }
}

class SwipeableContainer extends StatefulWidget {
  final String item;

  const SwipeableContainer({super.key, required this.item});

  @override
  SwipeableContainerState createState() => SwipeableContainerState();
}

class SwipeableContainerState extends State<SwipeableContainer> {
  double _containerPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Update container position based on swipe
          _containerPosition += details.delta.dx;
        });
      },
      onHorizontalDragEnd: (details) {
        // Reset container position when swipe ends
        setState(() {
          _containerPosition = 0.0;
        });
      },
      child: Stack(
        children: [
          Positioned(
            left: _containerPosition,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                widget.item,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
