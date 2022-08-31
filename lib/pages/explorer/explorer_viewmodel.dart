import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/pages/viewer/viewer.dart';

import '../../services/storage.dart';

final explorerViewModelProvider =
    ChangeNotifierProvider<ExplorerViewModel>((ref) => ExplorerViewModel(ref.read));

class ExplorerViewModel with ChangeNotifier {
  late StorageService storageService;
  final Reader reader;

  ExplorerViewModel(this.reader) {
    storageService = reader(storageServiceProvider);
  }

  Future<String?> pickAndReadTextFile(BuildContext context) async {
    final text = await storageService.pickAndReadTextFile();
    if (text != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewerPage(content: text),
        ),
      );
    } else {
      return '파일을 불러오지 못했습니다.';
    }
    return null;
  }
}
