import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/hooks/use_item_positions_listener.dart';
import 'package:noon_reader/hooks/use_item_scroll_controller.dart';
import 'package:noon_reader/models/history.dart';
import 'package:noon_reader/pages/viewer/viewer_viewmodel.dart';
import 'package:noon_reader/pages/viewer/widgets/history_viewer_container.dart';
import 'package:noon_reader/widgets/loading_indicator.dart';

import 'package:noon_reader/widgets/noon_app_bar.dart';

class ViewerPage extends HookConsumerWidget {
  final PlatformFile? file;

  const ViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewerViewModel = ref.watch(viewerViewModelProvider);

    final itemScrollController = useItemScrollController();
    final itemPositionsListener = useItemPositionsListener();

    final fileIdentifier = useMemoized(() => kIsWeb ? file?.name : file?.path);

    final buildHistoryViewerContainer = useCallback((String? content) {
      return HookBuilder(
        builder: (context) {
          final lines = useMemoized(() => content?.split("\n"));

          // Fetch last index and jump to last index
          final historyCallback = useCallback(() {
            final history = viewerViewModel.getHistory(fileIdentifier);
            return Future.microtask(
              () => itemScrollController.jumpTo(index: history.index ?? 0),
            );
          }, []);

          // Record current index
          final itemPositionCallback = useCallback(() {
            final identifier = kIsWeb ? file?.name : file?.path;
            saveHistory() async {
              final newIndex =
                  itemPositionsListener.itemPositions.value.first.index;
              if (newIndex != 0) {
                final newHistory = History(
                  index: newIndex,
                  maxIndex: lines?.length,
                  path: identifier,
                  timestamp: DateTime.now().millisecondsSinceEpoch,
                );
                viewerViewModel.saveHistory(fileIdentifier, newHistory);
              }
            }

            itemPositionsListener.itemPositions.addListener(saveHistory);
            return Future.microtask(() => saveHistory());
          }, []);

          return HistoryViewerContainer(
            initializer: () async {
              await historyCallback();
              await itemPositionCallback();
            },
            content: lines ?? [],
            setting: viewerViewModel.setting,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          );
        },
      );
    }, []);

    return Scaffold(
      appBar: const NoonAppBar(),
      body: FutureBuilder<String?>(
        future: viewerViewModel.readFileAsString(file),
        builder: (context, snapshot) {
          Widget widget = const LoadingIndicator();

          if (snapshot.hasData) {
            widget = buildHistoryViewerContainer(snapshot.data);
          }

          if (snapshot.hasError) {
            widget = Center(child: Text("에러 ${snapshot.error}"));
          }

          return widget;
        },
      ),
    );
  }
}
