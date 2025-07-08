import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'CustomSnackbar.dart';

class SharePopup extends StatelessWidget {
  final Uint8List qrImageBytes;

  const SharePopup({super.key, required this.qrImageBytes});

  Future<void> _shareImage(BuildContext context) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_share.png').create();
      await file.writeAsBytes(qrImageBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Here is my QR Code via QREviX',
      );
      Navigator.of(context).pop(); // optional: close popup after share
    } catch (e) {
      CustomSnackbar.show(context, message: 'Something went wrong!', isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Immediately trigger sharing and close the popup after.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shareImage(context);
    });

    return const SizedBox.shrink(); // empty UI
  }
}
