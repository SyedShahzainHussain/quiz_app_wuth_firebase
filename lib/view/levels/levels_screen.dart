import 'package:quiz_app_with_firebase/config/shimmer/level_shimmer.dart';

import 'level.dart';

class SubjectLevelScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  const SubjectLevelScreen({super.key, required this.subjectModel});

  @override
  State<SubjectLevelScreen> createState() => _SubjectLevelScreenState();
}

class _SubjectLevelScreenState extends State<SubjectLevelScreen> {
  QuizViewModel quizViewModel = QuizViewModel();

  @override
  void initState() {
    super.initState();
    quizViewModel.getQuizData(widget.subjectModel.Id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: widget.subjectModel.Title,
      ),
      body: LinearGradientWidget(
        child: ChangeNotifierProvider(
          create: (context) => quizViewModel,
          child: Consumer<QuizViewModel>(builder: (context, state, _) {
            switch (state.quizList.status) {
              case Status.loading:
                return const LevelShimmer();
              case Status.error:
                return Center(
                  child: Text(state.quizList.message.toString()),
                );
              case Status.success:
                return state.quizList.data!.isEmpty
                    ? Center(
                        child: Text(
                          "No Quiz Founds!",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return LevelViewWidget(
                            index: index,
                            state: state,
                          );
                        },
                        itemCount: state.quizList.data!.length,
                      );
              default:
                return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
