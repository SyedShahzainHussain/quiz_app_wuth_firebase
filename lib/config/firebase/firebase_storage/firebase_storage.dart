import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_with_firebase/config/helper/helper_function.dart';

class StorageModel {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadImage(
      String childname, File file, BuildContext context, String type) async {
    try {
      String fileType = file.path.split('.').last;
      Reference ref = storage.ref().child("subjects").child(childname);
      UploadTask uploadTask = ref.putFile(
          File(file.path).absolute,
          SettableMetadata(
            contentType: '$type/$fileType',
            customMetadata: {'picked-file-path': file.path},
          ));

      TaskSnapshot taskSnapshot = await uploadTask;
      String download = await taskSnapshot.ref.getDownloadURL();
      return download;
    } catch (e) {
      if (context.mounted) {
        HelperFunction.showSnackbar(e.toString(), context);
      }
      return null;
    }
  }
}
