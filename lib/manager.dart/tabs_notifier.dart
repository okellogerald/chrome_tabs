import 'package:chrome_tabs/manager.dart/tabs_details.dart';
import 'package:chrome_tabs/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/tab.dart';

final tabsNotifier =
    StateNotifierProvider<TabsNotifier, List<Tab>>((ref) => TabsNotifier(ref));

class TabsNotifier extends StateNotifier<List<Tab>> {
  final StateNotifierProviderRef ref;
  TabsNotifier(this.ref) : super([Tab.home()]);

  /// stores the name of the next tab.
  var _newTabIndex = 2;

  void addTab() {
    final tabs = List<Tab>.from(state);
    final tab = Tab(
        index: _newTabIndex,
        color: Utils.getRandomColor(),
        id: Utils.getRandomString());
    tabs.add(tab);
    _newTabIndex++;
    ref.read(currentTabIDProvider.state).state = tab.id;
    state = tabs;
  }

  void removeTab(String tabID) {
    final tabs = List<Tab>.from(state);
    final index = tabs.indexWhere((tab) => tab.id == tabID);
    tabs.removeAt(index);
    // checking if there are tabs left after removing the current tab
    final hasOtherTabs = tabs.isNotEmpty;
    if (hasOtherTabs) {
      // checking if the closed tab is the first tab
      final nextTabIndex = (index - 1).isNegative ? 0 : index - 1;
      final nextTab = tabs[nextTabIndex];
      ref.read(currentTabIDProvider.state).state = nextTab.id;
    }
    state = tabs;
  }
}
