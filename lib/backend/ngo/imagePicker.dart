import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


  final picker = ImagePicker();
  final List<XFile> imageList = [];

  // Future<List<XFile>> pickImageFromGallery() async {
  //   try {
  //     final List<XFile> images = await picker.pickMultiImage();
  //     if (images!.isNotEmpty) {
  //       imageList!.addAll(images);
  //     }
  //     return imageList;
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }
