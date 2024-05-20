import 'package:quiz_app_with_firebase/config/components/rounded_button_widget.dart';
import 'package:quiz_app_with_firebase/model/quesions/question_model.dart';
import 'package:quiz_app_with_firebase/view_model/unlocked_level_view_model.dart';

import 'result.dart';

class ResultScreen extends StatelessWidget {
  final List<QuestionsModel> questions;
  final int index;
  final QuizViewModel state;
  const ResultScreen(
      {super.key,
      required this.questions,
      required this.index,
      required this.state});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionViewModel>(context);
    int numTotalQuestions = questions.length;
    int numCorrectQuestions = provider
        .summaryData(questions)
        .where(
          (data) => data['user_answer'] == data['correct_answer'],
        )
        .length;

    final int score = (numCorrectQuestions / numTotalQuestions * 100).round();
    final nextLevelId = index + 1 < state.quizList.data!.length
        ? state.quizList.data![index + 1].id
        : null;
    if (nextLevelId != null && score > 60) {
      Provider.of<UnlockedLevelsModel>(context, listen: false)
          .unlockLevel(nextLevelId);
    }

    return Scaffold(
      body: LinearGradientWidget(
          child: SizedBox(
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly! ',
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 230, 200, 253),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: score > 60
                              ? successfullScore(context, numCorrectQuestions,
                                  numTotalQuestions)
                              : failurefullScore(context, numCorrectQuestions,
                                  numTotalQuestions)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      TextButtonWidget(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SubjectScreen()),
                              (route) => false);

                          Future.delayed(const Duration(seconds: 1), () {
                            provider.resetQuiz();
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        title: "Restart Quiz!",
                      ),
                      TextButtonWidget(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionsSummary(
                                      questions: questions,
                                    )),
                          );
                        },
                        icon: const Icon(Icons.question_answer),
                        title: "Check Answers",
                      ),
                    ],
                  ),
                  score > 60
                      ? RoundedButtonWidget(
                          width: double.infinity,
                          title: "Next Question",
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SubjectScreen()),
                                (route) => false);

                            Future.delayed(const Duration(seconds: 1), () {
                              provider.resetQuiz();
                            });
                          },
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Column successfullScore(
      BuildContext context, int numCorrectQuestions, int numTotalQuestions) {
    return Column(
      children: [
        Image.asset(
          'assets/winner.png',
          width: MediaQuery.sizeOf(context).width * .5,
          height: MediaQuery.sizeOf(context).height * .15,
          alignment: Alignment.center,
        ),
        Text(
          "Congrats!",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${(numCorrectQuestions / numTotalQuestions * 100).round()}%",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(width: 10),
            Text(
              "Score",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Column failurefullScore(
      BuildContext context, int numCorrectQuestions, int numTotalQuestions) {
    return Column(
      children: [
        Image.asset(
          'assets/next_time.png',
          width: MediaQuery.sizeOf(context).width * .5,
          height: MediaQuery.sizeOf(context).height * .15,
          alignment: Alignment.center,
        ),
        Text(
          "Better luck next time!",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${(numCorrectQuestions / numTotalQuestions * 100).round()}%",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(width: 10),
            Text(
              "Score",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
