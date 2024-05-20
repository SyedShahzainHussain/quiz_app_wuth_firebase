import 'package:quiz_app_with_firebase/admin/repository/upload_quiz.dart';
import 'package:quiz_app_with_firebase/config/helper/helper_function.dart';
import 'package:quiz_app_with_firebase/view/subjects/subjects.dart';

class UploadQuizViewModel with ChangeNotifier {
  UploadQuizRepository uploadQuizRepository = UploadQuizRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> uploadQuiz({
    required String level,
    required String question,
    required String correctAns,
    required BuildContext context,
    required List<String> answers,
    required String subjectTitle,
  }) async {
    setLoading(true);
    try {
      await uploadQuizRepository.postQuiz(
          level, question, correctAns, answers, subjectTitle);
      setLoading(false);
      if (context.mounted) {
        HelperFunction.showSnackbar("Quiz uploaded successfully", context);
      }
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        HelperFunction.showSnackbar(e.toString(), context);
      }
    }
  }
}
