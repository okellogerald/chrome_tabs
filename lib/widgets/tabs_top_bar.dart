import 'package:chrome_tabs/manager.dart/tabs_details.dart';
import 'package:chrome_tabs/manager.dart/tabs_notifier.dart';
import 'package:chrome_tabs/theme/colors.dart';
import 'package:chrome_tabs/widgets/app_icon_button.dart';
import 'package:chrome_tabs/widgets/tab_container.dart';
import 'package:chrome_tabs/widgets/tab_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsTopBar extends ConsumerStatefulWidget {
  const TabsTopBar({super.key});

  @override
  ConsumerState<TabsTopBar> createState() => _TabsTopBarState();
}

class _TabsTopBarState extends ConsumerState<TabsTopBar> {
  @override
  Widget build(BuildContext context) {
    final tabs = ref.watch(tabsNotifier);
    final currentTabID = ref.watch(currentTabIDProvider);

    return Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: AppColors.primary,
        child: Row(
          children: [
            ...(tabs.map((tab) {
              final isSelected = currentTabID == tab.id;
              final tabBackgroundColor =
                  isSelected ? AppColors.selectedTabColor : Colors.black;
              return Flexible(
                  child: TabContainer(
                color: tabBackgroundColor,
                child: TabTile(tab),
                isCurrentTab: isSelected,
                onTap: () =>
                    ref.read(currentTabIDProvider.state).state = tab.id,
              ));
            }).toList()),
            Expanded(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppIconButton(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        iconThemeData:
                            const IconThemeData(size: 15, color: Colors.white),
                        onPressed: ref.read(tabsNotifier.notifier).addTab,
                        icon: Icons.add)))
          ],
        ));
  }
}
