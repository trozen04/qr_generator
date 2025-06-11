import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CustomSnackbar.dart';

class FileSaver {
  static Future<void> saveFile({
    required BuildContext context,
    required Uint8List bytes,
    String? fileName,
  }) async {
    bool granted = false;

    if (Platform.isAndroid) {
      // Try request MANAGE_EXTERNAL_STORAGE permission explicitly first
      if (!await Permission.manageExternalStorage.isGranted) {
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          if (status.isPermanentlyDenied) {
            await openAppSettings();
          }
          CustomSnackbar.show(context, message: 'Storage permission denied', isSuccess: false);
          return;
        }
      }
      // granted if we reached here
      granted = true;
    } else {
      // iOS or others
      granted = true;
    }


    if (!granted) {
      CustomSnackbar.show(context,
          message: 'Storage permission denied', isSuccess: false);
      return;
    }

    try {
      // Save inside your app external storage directory to avoid problems
      final directory = await getExternalStorageDirectory();
      final path = directory?.path ?? '/storage/emulated/0/Download';

      final file = File(
        '$path/${fileName ?? 'qr_code_${DateTime.now().millisecondsSinceEpoch}.png'}',
      );

      await file.writeAsBytes(bytes);
      CustomSnackbar.show(context,
          message: 'File saved at: ${file.path}', isSuccess: true);
    } catch (e) {
      CustomSnackbar.show(context,
          message: 'Failed to save file: $e', isSuccess: false);
    }
  }
}
