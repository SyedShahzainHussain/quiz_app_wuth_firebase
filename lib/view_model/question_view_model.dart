import 'package:flutter/foundation.dart';
import 'package:quiz_app_with_firebase/model/quesions/question_model.dart';

class QuestionViewModel with ChangeNotifier {
  //! Get Question and update current Question
  int _currentQuestion = 0;
  int get currentQuestion => _currentQuestion;
  set setCurrentQuestion(int value) {
    _currentQuestion = value;
    notifyListeners();
  }

  //! Get Answer and update selected Answer
  List<String> _selectedAnswer = [];
  List<String> get selectedAnswer => _selectedAnswer;

  set setSelectedAnswer(String text) {
    _selectedAnswer.add(text);
    notifyListeners();
  }

  // ! reset quiz
  void resetQuiz() {
    setCurrentQuestion = 0;
    _selectedAnswer = [];
    notifyListeners();
  }

  // ! get summary data

  List<Map<String, Object>> summaryData(List<QuestionsModel> questions) {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].correctAns,
        'user_answer': selectedAnswer[i]
      });
    }
    return summary;
  }
}
