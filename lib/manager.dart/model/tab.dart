import 'package:flutter/material.dart';

class Tab {
  final String id;
  final int index;
  final Color color;
  const Tab({required this.index, required this.color, required this.id});

  Tab.home()
      : index = 1,
        color = Colors.white,
        id = 'default';
}
