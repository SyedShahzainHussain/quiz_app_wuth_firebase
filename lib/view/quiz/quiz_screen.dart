import "package:quiz_app_with_firebase/model/quesions/question_model.dart";
import "package:quiz_app_with_firebase/view/result/result_screen.dart";

import "quiz.dart";

class QuizScreen extends StatefulWidget {
  final QuizViewModel state;
  final String levelId;
  final List<QuestionsModel> questions;
  final int index;
  const QuizScreen(
      {super.key,
      required this.questions,
      required this.levelId,
      required this.index,
      required this.state});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<QuestionViewModel>(context, listen: false).resetQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionViewModel>(context);
    final question = widget.questions[provider.currentQuestion];
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        provider.resetQuiz();
        if (context.mounted) {
          return Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        appBar: CustomAppBarWidget(title: "Level ${widget.levelId}"),
        body: LinearGradientWidget(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 30,
                    ),
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Text(
                        question.question,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final answer = question.answer[index].toString();
                      return Container(
                        margin: const EdgeInsets.only(left: 12.0, right: 12.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.purple),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              provider.setSelectedAnswer = answer;

                              if (provider.selectedAnswer.length ==
                                  widget.questions.length) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                        questions: widget.questions,
                                        index: widget.index,
                                        state: widget.state,
                                      ),
                                    ));
                              } else {
                                provider.setCurrentQuestion =
                                    provider.currentQuestion + 1;
                              }
                            },
                            borderRadius: BorderRadius.circular(15),
                            splashColor: AppColors.purple.withOpacity(0.5),
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                answer,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: question.answer.length,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
