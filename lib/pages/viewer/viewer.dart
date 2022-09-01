import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/hooks/use_item_positions_listener.dart';
import 'package:noon_reader/hooks/use_item_scroll_controller.dart';
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

    final fileIdentifier = kIsWeb ? file?.name : file?.path;

    // ViewerContainer 초기화 후 실행해야하는 함수
    final initializer = useCallback((ValueNotifier<bool> visible) {
      // 이전 기록 가져오기
      final initialIndex = viewerViewModel.getHistory(fileIdentifier);

      // 기록된 index로 이동
      Future.microtask(
        () => itemScrollController.jumpTo(index: initialIndex),
      ).then((value) {
        // 초기화 완료
        visible.value = true;

        // 스크롤 모니터링 -> 기록
        itemPositionsListener.itemPositions.addListener(() async {
          final newIndex =
              itemPositionsListener.itemPositions.value.first.index;
          if (newIndex != 0) {
            await viewerViewModel.saveHistory(fileIdentifier, newIndex);
          }
        });
      });

      return null;
    }, []);

    return Scaffold(
      appBar: const NoonAppBar(),
      body: FutureBuilder<String?>(
        future: viewerViewModel.readFileAsString(file),
        builder: (context, snapshot) {
          Widget widget = const LoadingIndicator();

          if (snapshot.hasData) {
            widget = HistoryViewerContainer(
              initializer: initializer,
              content: snapshot.data,
              setting: viewerViewModel.setting,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
            );
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
