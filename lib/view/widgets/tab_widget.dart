import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final int index;
  final int selectedIndex;

  const TabWidget({
    super.key,
    required this.text,
    required this.index,
    required this.icon,
    required this.iconColor,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(color: selectedIndex==index?Colors.grey.shade100:Colors.transparent),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            Text(
              '  $text',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
