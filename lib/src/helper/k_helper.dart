import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kurd_tree/src/helper/spcolor.dart';

class KHelper {
  static Future<File?> pickImageFromGallery({bool cropTheImage = false}) async {
    File? myImageFile;

    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? imageXFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageXFile != null) {
      myImageFile = File(imageXFile.path);

      if (cropTheImage) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: myImageFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.png,
          maxHeight: 1080,
          maxWidth: 1080,
          compressQuality: 50,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioLockEnabled: true,
              aspectRatioLockDimensionSwapEnabled: false,
              aspectRatioPickerButtonHidden: true,
              resetAspectRatioEnabled: false,
            ),
          ],
        );
        if (croppedFile != null) {
          myImageFile = File(croppedFile.path);
        }
      }
    } else {
      myImageFile = null;
    }

    return myImageFile;
  }

  static showSnackBar(text) {
    Get.showSnackbar(GetSnackBar(
      message: text,
      messageText: Text(
        text,
        style: TextStyle(
          color: SPColors.dark,
          fontSize: 14,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      borderRadius: 13,
      duration: 2.seconds,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      boxShadows: const [
        BoxShadow(
          blurRadius: 5,
          color: Colors.black38,
          offset: Offset(
            1,
            3,
          ),
        )
      ],
    ));
  }
}
