import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final pickedImages = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImages != null) {
      return File(pickedImages.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
