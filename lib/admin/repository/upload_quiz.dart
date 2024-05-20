import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app_with_firebase/model/quesions/question_model.dart';
import 'package:quiz_app_with_firebase/model/quiz_model/quiz_model.dart';

class UploadQuizRepository {
  FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  Future<void> postQuiz(String level, String question, String correctAns,
      List<String> answers, String subjectTitle) async {
    try {
      final newQuestion = QuestionsModel(
        correctAns: correctAns.toLowerCase(),
        question: question.toLowerCase(),
        answer: answers,
      );
      final subjectDoc = await firebaseStore
          .collection("subjects")
          .where("Title", isEqualTo: subjectTitle)
          .get();
      // ! get subjectId

      final subjectId = subjectDoc.docs.first.id;
      // ! get quizzes
      final quizzes = await firebaseStore
          .collection("subjects")
          .doc(subjectId)
          .collection("quiz")
          .where("level", isEqualTo: level)
          .get();
      // ! if quiz is not empty
      if (quizzes.docs.isNotEmpty) {
        final quizDoc = quizzes.docs.first;
        final quizData = QuizModel.fromJson(quizDoc.data());

        final updatedQuestion = List<QuestionsModel>.from(quizData.questions);
        updatedQuestion.add(newQuestion);
        final updatedQuiz = quizData.copyWith(questions: updatedQuestion);
        await firebaseStore
            .collection("subjects")
            .doc(subjectId)
            .collection("quiz")
            .doc(quizDoc.id)
            .update(updatedQuiz.toJson());
      } else {
        // ! if quiz is  empty
        final newQuiz = QuizModel(level: level, questions: [newQuestion]);
        final jsonToSet = newQuiz.toJson();
        await firebaseStore
            .collection("subjects")
            .doc(subjectId)
            .collection("quiz")
            .doc()
            .set(jsonToSet);
      }
    } catch (e) {
      rethrow;
    }
  }
}
