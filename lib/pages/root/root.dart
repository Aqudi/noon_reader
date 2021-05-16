import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/pages/explorer/explorer.dart';
import 'package:noon_reader/pages/history/history.dart';
import 'package:noon_reader/pages/setting/setting.dart';

import 'root_viewmodel.dart';

class RootPage extends HookWidget {
  Widget getSelectedPage(int index) {
    switch (index) {
      case 0:
        return HistoryPage();
      case 1:
        return ExplorerPage();
      case 2:
        return SettingPage();
      default:
        return Center(child: Text('404 Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final rootViewModel = useProvider(rootViewModelProvider);

    final selectedIndex = rootViewModel.selectedIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text('Noon Reader'),
        centerTitle: true,
      ),
      body: Center(
        child: getSelectedPage(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: rootViewModel.setSelectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
