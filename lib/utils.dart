import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static const uuid = Uuid();

  static String getRandomString() => uuid.v4();

  static Color getRandomColor() =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
