import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/models/history.dart';
import 'package:noon_reader/pages/history/history_viewmodel.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyViewModel = ref.read(HistoryViewModelProvider);

    final histories = useState<List<History>>([]);
    useEffect(
      () {
        histories.value = historyViewModel.getAllHistory();
        return null;
      },
    );

    return ListView.builder(
      itemCount: histories.value.length,
      itemBuilder: (context, index) {
        final history = histories.value[index];
        final filename = history.path?.split("/").last ?? "";
        print(history);

        Widget widget = const SizedBox();

        if (filename.isNotEmpty) {
          widget = ListTile(
            title: Text(filename),
            subtitle: Text(history.path ?? ""),
          );
        }

        return widget;
      },
    );
  }
}
