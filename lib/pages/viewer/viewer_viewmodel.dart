import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/models/history.dart';

import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/services/storage.dart';

final viewerViewModelProvider = ChangeNotifierProvider<ViewerViewModel>((ref) {
  final settingService = ref.watch(settingServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  return ViewerViewModel(
    settingService,
    storageService,
  );
});

class ViewerViewModel with ChangeNotifier {
  ViewerViewModel(this._settingService, this._storageService);

  final SettingService _settingService;
  final StorageService _storageService;

  Setting get setting => _settingService.setting;

  Future<String?> readFileAsString(PlatformFile? file) async {
    if (file != null) {
      return _storageService.readFileAsString(file);
    }
    return null;
  }

  History getHistory(String? filePath) {
    late History index;
    if (filePath != null) {
      final history = _storageService.get(BoxName.history, filePath) ?? {};
      print(history);
      index = History();
    }
    return History();
  }

  Future<void> saveHistory(String? filePath, History history) async {
    if (filePath != null) {
      await _storageService.put(BoxName.history, filePath, history.toJson());
    }
  }
}
