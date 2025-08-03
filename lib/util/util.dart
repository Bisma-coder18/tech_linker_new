import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Util {
  
  // Request permission for camera or gallery
  static Future<bool> _requestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      return status.isGranted;
    } else {
      final status = await Permission.photos.request(); // for iOS
      final storageStatus = await Permission.storage.request(); // for Android
      return status.isGranted || storageStatus.isGranted;
    }
  }

  // Open Camera
  static Future<File?> openCamera() async {
    final ImagePicker _picker=ImagePicker();
    try {
      bool hasPermission = await _requestPermission(ImageSource.camera);
      if (!hasPermission) {
        print("Camera permission not granted.");
        return null;
      }
    
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      return photo != null ? File(photo.path) : null;
    } catch (e) {
      print('Error opening camera: $e');
      return null;
    }
  }

  // Open Gallery
  static Future<File?> openGallery() async {
    final ImagePicker _picker=ImagePicker();

    try {
      bool hasPermission = await _requestPermission(ImageSource.gallery);
      if (!hasPermission) {
        print("Gallery permission not granted.");
        return null;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      return image != null ? File(image.path) : null;
    } catch (e) {
      print('Error opening gallery: $e');
      return null;
    }
  }

}
