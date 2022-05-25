import 'package:chrome_tabs/manager.dart/model/tab.dart';
import 'package:chrome_tabs/manager.dart/tabs_details.dart';
import 'package:chrome_tabs/manager.dart/tabs_notifier.dart';
import 'package:chrome_tabs/widgets/app_icon_button.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabTile extends ConsumerWidget {
  final Tab tab;
  const TabTile(this.tab, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTabID = ref.watch(currentTabIDProvider);
    final isSelected = currentTabID == tab.id;

    return Container(
      height: 35,
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: tab.color, radius: 7),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            'Tab ${tab.index}',
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 12, color: isSelected ? Colors.black : Colors.white),
          )),
          AppIconButton(
              width: 20,
              height: 20,
              icon: Icons.close,
              iconThemeData: IconThemeData(
                  color: isSelected ? Colors.black : Colors.white, size: 13),
              onPressed: () =>
                  ref.read(tabsNotifier.notifier).removeTab(tab.id)),
        ],
      ),
    );
  }
}
