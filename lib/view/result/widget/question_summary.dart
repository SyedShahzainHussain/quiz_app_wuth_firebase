import 'package:quiz_app_with_firebase/model/quesions/question_model.dart';

import '../result.dart';

class QuestionsSummary extends StatelessWidget {
  final List<QuestionsModel> questions;
  const QuestionsSummary({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionViewModel>(context);
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Answers",
      ),
      extendBody: true,
      body: LinearGradientWidget(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: ListView(
            children: provider
                .summaryData(questions)
                .map((data) => SummaryItem(data))
                .toList(),
          ),
        ),
      ),
    );
  }
}
