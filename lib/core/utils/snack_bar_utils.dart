import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message,{required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      margin: const EdgeInsets.all(24),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    ),
  );
}
