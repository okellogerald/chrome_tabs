import 'package:chrome_tabs/theme/colors.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: 1.5, height: 17, color: AppColors.highlightColor2);
  }
}
