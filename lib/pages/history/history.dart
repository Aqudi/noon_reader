import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/models/history.dart';
import 'package:noon_reader/pages/history/history_viewmodel.dart';
import 'package:noon_reader/pages/viewer/viewer.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyViewModel = ref.read(historyViewModelProvider);

    final histories = useState<List<History>>([]);
    useEffect(
      () {
        histories.value = historyViewModel.getAllHistory();
        return null;
      },
    );

    return ListView.builder(
      itemExtent: 80,
      itemCount: histories.value.length,
      itemBuilder: (context, index) {
        final history = histories.value[index];
        final filename = history.path?.split("/").last ?? "";

        Widget widget = const SizedBox();

        if (filename.isNotEmpty) {
          final timestamp = history.timestamp ?? 0;
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp);

          widget = ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewerPage(filePath: history.path),
                ),
              );
            },
            minLeadingWidth: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${history.index}/${history.maxIndex}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "${date.year}-${date.month.toString().padLeft(2, "0")}-"
                  "${date.day.toString().padLeft(2, "0")} "
                  "${date.hour}:${date.minute}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        return widget;
      },
    );
  }
}
