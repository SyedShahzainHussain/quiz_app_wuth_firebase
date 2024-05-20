import 'package:flutter/foundation.dart';
import 'package:quiz_app_with_firebase/data/network/firebase_data.dart';
import 'package:quiz_app_with_firebase/data/response/response.dart';
import 'package:quiz_app_with_firebase/model/quiz_model/quiz_model.dart';

class QuizViewModel with ChangeNotifier {
  ApiResponse<List<QuizModel>> quizList = ApiResponse.loading();

  setQuizList(ApiResponse<List<QuizModel>> quizList) {
    this.quizList = quizList;
    notifyListeners();
  }

  Future<void> getQuizData(String id) async {
    FirebaseData.getQuizData(id).then((value) {
      
      setQuizList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
      setQuizList(ApiResponse.error(error.toString()));
    });
  }
}
