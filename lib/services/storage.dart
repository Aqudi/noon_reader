import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageServiceProvider = Provider<StorageService>(
  (ref) => throw UnimplementedError(),
);

enum BoxName {
  setting,
  history,
}

class StorageService {
  final utf8Decoder = const Utf8Decoder();

  bool initialized = false;
  final boxes = <BoxName, Box<String>>{};

  Future<PlatformFile?> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
        withReadStream: true,
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
    if (file.bytes != null) {
      return utf8Decoder.convert(file.bytes!);
    }
    return null;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    for (final boxName in BoxName.values) {
      final box = await Hive.openBox<String>(boxName.toString());
      boxes.putIfAbsent(boxName, () => box);
    }
    initialized = true;
  }

  Future<void> put(
      BoxName boxName, String key, Map<String, dynamic> value) async {
    await boxes[boxName]!.put(key, jsonEncode(value));
  }

  Map<String, dynamic>? get(BoxName boxName, String key) {
    try {
      if (boxes[boxName]!.get(key) != null) {
        return jsonDecode(boxes[boxName]!.get(key)!);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  void delete(BoxName boxName, String key) {
    boxes[boxName]!.delete(key);
  }
}
