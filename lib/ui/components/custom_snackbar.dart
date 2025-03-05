import 'package:flutter/material.dart';

void customSnackbar(BuildContext context, IconData icon, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: const Color(0xFF44FF70),
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Text(
          message,
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
  ));
}
