import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final _imagePicker = ImagePicker();

  static Future<File?> pickImage() async {
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    }
    return null;
  }
}
