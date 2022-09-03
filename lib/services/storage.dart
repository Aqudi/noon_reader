import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:noon_reader/top_level_provider.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  final logger = ref.read(loggerProvider);
  return StorageService(logger);
});

enum BoxName {
  setting,
  history,
}

class StorageService {
  final Logger _logger;
  final utf8Decoder = const Utf8Decoder();
  final boxes = <BoxName, Box<String>>{};

  StorageService(this._logger);

  bool initialized = false;

  Future<PlatformFile?> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
        withData: true,
      );
      if (result != null) {
        return result.files.single;
      }
    } on PlatformException catch (e) {
      throw Exception('Unsupported operation$e');
    } catch (ex) {
      throw Exception(ex);
    }
    return null;
  }

  Future<String?> readFileAsString(PlatformFile file) async {
    _logger.d("Read file name: ${file.name}");
    if (file.bytes != null) {
      return utf8Decoder.convert(file.bytes!);
    }
    return null;
  }

  Future<void> init() async {
    if (!initialized) {
      _logger.d("Initialize StorageService");
      await Hive.initFlutter();
      for (final boxName in BoxName.values) {
        final box = await Hive.openBox<String>(boxName.toString());
        boxes.putIfAbsent(boxName, () => box);
      }
      initialized = true;
    } else {
      _logger.d("StorageService is already initialized");
    }
  }

  Future<void> put(
      BoxName boxName, String key, Map<String, dynamic> value) async {
    _logger.d("put $boxName.$key = $value");
    await boxes[boxName]!.put(key, jsonEncode(value));
  }

  Map<String, dynamic>? get(BoxName boxName, String key) {
    try {
      _logger.d("get $boxName.$key, ${boxes[boxName]?.keys}");
      if (boxes[boxName]!.get(key) != null) {
        return jsonDecode(boxes[boxName]!.get(key)!);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  List? getKeys(BoxName boxName) {
    return boxes[boxName]?.keys.toList();
  }

  void delete(BoxName boxName, String key) {
    boxes[boxName]!.delete(key);
  }
}
