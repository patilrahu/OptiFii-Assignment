import 'dart:ui';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class UploadBill {
  static Future<XFile?> pickBillImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static Future<Map<String, String>> processBillImage(XFile file) async {
    final inputImage = InputImage.fromFilePath(file.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    List<Line> lines = [];
    for (var block in recognizedText.blocks) {
      for (var line in block.lines) {
        lines.add(Line(line.text, line.boundingBox));
      }
    }

    Map<String, String> fieldValues = {};
    for (var fieldLine in lines.where((l) => isFieldName(l.text))) {
      Line? bestMatch;
      double minYDiff = double.infinity;

      for (var valueLine in lines) {
        if (valueLine.rect.left > fieldLine.rect.right) {
          double yDiff = (valueLine.rect.top - fieldLine.rect.top).abs();
          if (yDiff < minYDiff) {
            minYDiff = yDiff;
            bestMatch = valueLine;
          }
        }
      }

      if (bestMatch != null) {
        fieldValues[fieldLine.text] = bestMatch.text;
      }
    }
    await textRecognizer.close();
    return fieldValues;
  }
}

bool isFieldName(String text) {
  final lower = text.toLowerCase();
  final fields = [
    'wallet',
    'add amount',
    'purpose',
    'merchant',
    'meracht',
    'remark',
    'selected date',
    'selected category'
  ];
  return fields.any((f) => lower.contains(f));
}

class Line {
  final String text;
  final Rect rect;
  Line(this.text, this.rect);
}
