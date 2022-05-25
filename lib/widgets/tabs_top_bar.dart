import 'package:chrome_tabs/manager.dart/tabs_details.dart';
import 'package:chrome_tabs/manager.dart/tabs_notifier.dart';
import 'package:chrome_tabs/theme/colors.dart';
import 'package:chrome_tabs/widgets/app_icon_button.dart';
import 'package:chrome_tabs/widgets/separator.dart';
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
            ...(List.generate(tabs.length, (index) {
              final tab = tabs[index];
              final selectedIndex =
                  tabs.indexWhere((tab) => tab.id == currentTabID);
              final isSelected = currentTabID == tab.id;

              final tabBackgroundColor =
                  isSelected ? AppColors.selectedTabColor : Colors.black;

              final hasSeparator =
                  index != selectedIndex - 1 && index != selectedIndex;
              return Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TabContainer(
                        color: tabBackgroundColor,
                        child: TabTile(tab),
                        isCurrentTab: isSelected,
                        hideLeftAngle: index == selectedIndex + 1,
                        onTap: () =>
                            ref.read(currentTabIDProvider.state).state = tab.id,
                      ),
                    ),
                    if (hasSeparator) const Separator()
                  ],
                ),
              );
            })),
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
