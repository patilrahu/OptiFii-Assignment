import 'dart:ui';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remburshiment_app/utils/app_logger.dart';

class UploadBill {
  static Future<XFile?> pickBillImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static Future<String> processBillImage(XFile file) async {
    final inputImage = InputImage.fromFilePath(file.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    // List<Line> lines = [];
    // for (var block in recognizedText.blocks) {
    //   for (var line in block.lines) {
    //     lines.add(Line(line.text, line.boundingBox));
    //   }
    // }

    // Map<String, String> fieldValues = {};
    // for (var fieldLine in lines.where((l) => isFieldName(l.text))) {
    //   Line? bestMatch;
    //   double minYDiff = double.infinity;

    //   for (var valueLine in lines) {
    //     if (valueLine.rect.left > fieldLine.rect.right) {
    //       double yDiff = (valueLine.rect.top - fieldLine.rect.top).abs();
    //       if (yDiff < minYDiff) {
    //         minYDiff = yDiff;
    //         bestMatch = valueLine;
    //       }
    //     }
    //   }

    //   if (bestMatch != null) {
    //     fieldValues[fieldLine.text] = bestMatch.text;
    //   }
    // }
    await textRecognizer.close();
    return recognizedText.text;
  }

  static Future<String> getDataUsingAi(String receiptText) async {
    final model = GenerativeModel(
      model: 'models/gemini-2.5-flash',
      apiKey: 'AIzaSyCGuuCHqgeri0U54KNgID8jMw9GGh_w0Ko',
    );

    final response = await model.generateContent([
      Content.text(
          "Extract Amount, Merchant, Date, Category, Merchant Name, Wallet,Purpose ,Remark from:\n$receiptText make json object.")
    ]);
    print(response.text);
    return response.text.toString();
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
