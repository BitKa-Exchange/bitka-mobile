import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

abstract final class WidgetToImageSaver {
  static Future<bool> captureAndSave({
    required Widget targetWidget,
    required double targetWidth,
    required double targetHeight,
    String fileName = 'receipt',
  }) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final status = await Permission.storage.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        debugPrint("Storage permission denied. Cannot save file.");
        return false;
      }
    }

    final ScreenshotController screenshotController = ScreenshotController();
    Uint8List? pngBytes;
    try {
      // Wrap the provided widget in a minimal app/environment so
      // inherited widgets (Theme, MediaQuery, Directionality) are
      // available when the screenshot package builds it offscreen.
      final Widget widgetToCapture = MediaQuery(
        data: MediaQueryData(size: ui.Size(targetWidth, targetHeight)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: targetWidget),
            ),
          ),
        ),
      );

      pngBytes = await screenshotController.captureFromWidget(
        widgetToCapture,
        targetSize: ui.Size(targetWidth, targetHeight),
        pixelRatio: 3.0,
      );
    } catch (e) {
      debugPrint("Error capturing widget to image: $e");
      return false;
    }

    // ignore: unnecessary_null_comparison, dead_code
    if (pngBytes == null) {
      debugPrint("Captured bytes are null.");
      return false;
    }

    final directory = await getTemporaryDirectory();
    final String uniqueFileName =
        '${fileName}_${DateTime.now().millisecondsSinceEpoch}.png';
    final File tempFile = File('${directory.path}/$uniqueFileName');
    await tempFile.writeAsBytes(pngBytes, flush: true);

    try {
      String finalPath;

      if (Platform.isAndroid) {
        final externalDir = await getExternalStorageDirectory();

        finalPath = '${externalDir?.path}/Pictures/Bitka/$uniqueFileName';

        final Directory bitkaDir =
            Directory('${externalDir?.path}/Pictures/Bitka');
        if (!await bitkaDir.exists()) {
          await bitkaDir.create(recursive: true);
        }

        await tempFile.copy(finalPath);

        final result =
            await ImageGallerySaver.saveFile(finalPath, name: uniqueFileName);
        final bool success = result['isSuccess'] == true;

        await tempFile.delete();

        return success;
      } else if (Platform.isIOS) {
        final result =
            await ImageGallerySaver.saveFile(tempFile.path, name: uniqueFileName);
        final bool success = result['isSuccess'] == true;

        await tempFile.delete();

        return success;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error saving image to gallery/folder: $e");
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
      return false;
    }
  }
}