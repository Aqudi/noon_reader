import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/pages/viewer/viewer.dart';

import 'explorer_viewmodel.dart';

class ExplorerPage extends HookConsumerWidget {
  const ExplorerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final explorerViewModel = ref.watch(explorerViewModelProvider);

    // 현재 context의 navigator 저장
    final navigator = Navigator.of(context);

    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final file = await explorerViewModel.pickFile();
          navigator.push(
            MaterialPageRoute(
              builder: (_) => ViewerPage(filePath: file?.path),
            ),
          );
        },
        child: const Text('파일 열기'),
      ),
    );
  }
}
