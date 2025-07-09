import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CustomSnackbar.dart';

class FileSaver {
  static const MethodChannel _channel = MethodChannel('com.trozen.qr_code_generator/filesaver');

  static Future<void> saveFile({
    required BuildContext context,
    required Uint8List bytes,
    String? fileName,
  }) async {
    try {
      final result = await _channel.invokeMethod('saveImageToGallery', {
        'fileName': fileName ?? 'qr_code_${DateTime.now().millisecondsSinceEpoch}.png',
        'bytes': bytes,
      });

      CustomSnackbar.show(context, message: result ?? 'Saved!', isSuccess: true);
    } catch (e) {
      CustomSnackbar.show(context, message: 'Failed to save file: $e', isSuccess: false);
    }
  }
}
