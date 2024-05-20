import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_with_firebase/config/firebase/firebase_storage/firebase_storage.dart';
import 'package:quiz_app_with_firebase/config/helper/helper_function.dart';
import 'package:quiz_app_with_firebase/model/subject_model/subject_model.dart';

class UploadSubjectRepository {
  StorageModel storageModel = StorageModel();
  FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  Future<void> uploadSubject(
      {required File file,
      required BuildContext context,
      required String title}) async {
    try {
      // Proceed with uploading the image and storing the subject
      String? imageUrl =
          await storageModel.uploadImage("image", file, context, "image");

      if (imageUrl != null) {
        await postSubject(imageUrl, title);
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunction.showSnackbar(e.toString(), context);
      }
    }
  }

  Future<void> postSubject(String image, String title) async {
    try {
      final datas = SubjectModel(Image: image, Title: title.toLowerCase());
      await firebaseStore.collection("subjects").doc().set(datas.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkTitleExists(String title) async {
    try {
      final querySnapshot = await firebaseStore
          .collection("subjects")
          .where("Title", isEqualTo: title.toLowerCase())
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
