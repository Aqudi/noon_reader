import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/storage.dart';

final explorerViewModelProvider = ChangeNotifierProvider<ExplorerViewModel>(
    (ref) => ExplorerViewModel(ref.read));

class ExplorerViewModel with ChangeNotifier {
  late StorageService storageService;
  final Reader reader;

  ExplorerViewModel(this.reader) {
    storageService = reader(storageServiceProvider);
  }

  Future<PlatformFile?> pickFile() async {
    try {
      final file = await storageService.pickFile();
      return file;
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
