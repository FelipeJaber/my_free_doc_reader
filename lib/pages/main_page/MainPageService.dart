import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';

class MainPageService {
  Future<XFile?> getImageFromDevice() async {
    XFile? newFile = await openFile();
    return newFile;
  }

  Future<XFile?> takePictureUsingCamera(CameraController camera) async {
    XFile? newFile = await camera.takePicture();
    return newFile;
  }

  Future<String> extractTextFromPicture(File file) async {
    String response = await FlutterTesseractOcr.extractText(file.path);
    await Clipboard.setData(ClipboardData(text: response));
    return response;
  }
}
