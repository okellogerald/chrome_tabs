import 'package:chrome_tabs/theme/colors.dart';
import 'package:chrome_tabs/widgets/tabs_top_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const TabsTopBar(),
          Expanded(
              child: Container(
            color: AppColors.selectedTabColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                    child: Text('BODY',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
