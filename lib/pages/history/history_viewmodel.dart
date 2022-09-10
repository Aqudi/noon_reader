import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/models/history.dart';

import 'package:noon_reader/services/storage.dart';

final historyViewModelProvider =
    ChangeNotifierProvider<HistoryViewModel>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return HistoryViewModel(
    storageService,
  );
});

class HistoryViewModel with ChangeNotifier {
  HistoryViewModel(this._storageService);

  final StorageService _storageService;

  List<History> getAllHistory() {
    List<History> result = [];

    final keys = _storageService.getKeys(BoxName.history) ?? [];
    for (var key in keys) {
      final history = _storageService.get(BoxName.history, key) ?? {};
      result.add(
        History.fromJson(history),
      );
    }

    return result;
  }
}
