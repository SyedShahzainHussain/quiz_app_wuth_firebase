import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app_with_firebase/model/quiz_model/quiz_model.dart';
import 'package:quiz_app_with_firebase/model/subject_model/subject_model.dart';

class FirebaseData {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static Future<List<SubjectModel>> getSubjectData() async {
    try {
      final data = await _firebaseFirestore.collection("subjects").get();
      final list = data.docs
          .map((documents) => SubjectModel.fromSnapShot(documents))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<QuizModel>> getQuizData(String id) async {
    try {
      final data = await _firebaseFirestore
          .collection("subjects")
          .doc(id)
          .collection("quiz")
          .orderBy("Level".toLowerCase())
          .get();

      final list = data.docs
          .map((documents) => QuizModel.fromSnapShot(documents))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
