import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:noon_reader/pages/explorer/explorer.dart';
import 'package:noon_reader/pages/history/history.dart';
import 'package:noon_reader/pages/setting/setting.dart';
import 'package:noon_reader/widgets/noon_app_bar.dart';

import '../../generated/locale_keys.g.dart';
import 'root_viewmodel.dart';

class RootPage extends HookConsumerWidget {
  const RootPage({Key? key}) : super(key: key);

  Widget getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const HistoryPage();
      case 1:
        return const ExplorerPage();
      case 2:
        return const SettingPage();
      default:
        return Center(child: const Text('404 Page not found').tr());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootViewModel = ref.watch(rootViewModelProvider);

    final selectedIndex = rootViewModel.selectedIndex;

    return Scaffold(
      appBar: const NoonAppBar(),
      body: Center(
        child: getSelectedPage(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: rootViewModel.setSelectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: LocaleKeys.history_label.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: LocaleKeys.explorer_label.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: LocaleKeys.setting_label.tr(),
          ),
        ],
      ),
    );
  }
}
