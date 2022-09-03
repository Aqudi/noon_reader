import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:noon_reader/models/history.dart';

import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/services/storage.dart';
import 'package:noon_reader/top_level_provider.dart';

final viewerViewModelProvider = ChangeNotifierProvider<ViewerViewModel>((ref) {
  final logger = ref.watch(loggerProvider);
  final settingService = ref.watch(settingServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  return ViewerViewModel(
    logger,
    settingService,
    storageService,
  );
});

class ViewerViewModel with ChangeNotifier {
  final Logger _logger;
  final SettingService _settingService;
  final StorageService _storageService;

  ViewerViewModel(this._logger, this._settingService, this._storageService);

  Setting get setting => _settingService.setting;

  Future<String?> readFileAsString(PlatformFile? file) async {
    if (file != null) {
      return _storageService.readFileAsString(file);
    }
    return null;
  }

  History getHistory(String? filePath) {
    History? history;
    if (filePath != null) {
      final json = _storageService.get(BoxName.history, filePath) ?? {};
      history = History.fromJson(json);
    }
    return history ?? History();
  }

  Future<void> saveHistory(String? filePath, History history) async {
    if (filePath != null) {
      await _storageService.put(BoxName.history, filePath, history.toJson());
    }
  }
}
