import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'explorer_viewmodel.dart';

class ExplorerPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final explorerViewModel = useProvider(explorerViewModelProvider);
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await explorerViewModel.pickAndReadTextFile(context);
        },
        child: Text('파일 열기'),
      ),
    );
  }
}
