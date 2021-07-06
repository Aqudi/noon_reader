import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageServiceProvider = Provider<StorageService>(
  (ref) => StorageService(),
);

class StorageService {
  final utf8Decoder = Utf8Decoder();

  /// Pick and return txt file
  Future<String?> pickAndReadTextFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
      if (result != null && result.files.first.bytes != null) {
        final bytes = result.files.first.bytes;
        return utf8Decoder.convert(bytes!);
      }
    } on PlatformException catch (e) {
      throw Exception('Unsupported operation' + e.toString());
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
