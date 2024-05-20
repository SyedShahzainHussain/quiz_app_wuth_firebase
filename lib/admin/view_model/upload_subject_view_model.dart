import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_app_with_firebase/admin/repository/upload_subject.dart';
import 'package:quiz_app_with_firebase/config/helper/helper_function.dart';

class UploadSubjectViewModel with ChangeNotifier {
  UploadSubjectRepository uploadSubjectRepository = UploadSubjectRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> uploadSubject({
    required File file,
    required BuildContext context,
    required String title,
  }) async {
    setLoading(true);
    try {
      await uploadSubjectRepository.uploadSubject(
          file: file, context: context, title: title);
      setLoading(false);
      // Show success message only if the subject is uploaded
      if (context.mounted) {
        HelperFunction.showSnackbar("Subject uploaded successfully", context);
      }
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        HelperFunction.showSnackbar(e.toString(), context);
      }
    }
  }

  Future<bool> checkTitleExists({
    required String title,
  }) async {
    setLoading(true);
    final titleExists =
        await uploadSubjectRepository.checkTitleExists(title);
    if (!titleExists) {
      setLoading(false);
      return false;
    } else {
      setLoading(false);
      return true;
    }
  }
}
