import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'explorer_viewmodel.dart';

class ExplorerPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final explorerViewModel = ref.watch(explorerViewModelProvider);
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await explorerViewModel.pickAndReadTextFile(context);
        },
        child: const Text('파일 열기'),
      ),
    );
  }
}
