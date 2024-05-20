import 'package:flutter/foundation.dart';
import 'package:quiz_app_with_firebase/data/network/firebase_data.dart';
import 'package:quiz_app_with_firebase/data/response/response.dart';
import 'package:quiz_app_with_firebase/model/subject_model/subject_model.dart';

class SubjectViewModel with ChangeNotifier {
  ApiResponse<List<SubjectModel>> subjectList = ApiResponse.loading();

  setSubjectList(ApiResponse<List<SubjectModel>> subjectList) {
    this.subjectList = subjectList;
    notifyListeners();
  }

  Future<void> getSubjectData() async {
    await FirebaseData.getSubjectData().then((value) {
      if (kDebugMode) {
        print(value);
      }
      setSubjectList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
      setSubjectList(ApiResponse.error(error.toString()));
    });
  }
}
