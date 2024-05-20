import 'subjects.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SubjectViewModel>(context, listen: false).getSubjectData();
    Future.delayed(Duration.zero, () {
      Provider.of<QuestionViewModel>(context, listen: false).resetQuiz();
      Provider.of<UnlockedLevelsModel>(context, listen: false)
          .loadUnlockedLevels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Subjects",
        action: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddSubjectScreen()));
              },
              icon: const Icon(Icons.upload))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<SubjectViewModel>(context, listen: false)
              .getSubjectData();
        },
        child: LinearGradientWidget(
          child: Consumer<SubjectViewModel>(builder: (context, state, _) {
            switch (state.subjectList.status) {
              case Status.loading:
                return const SubjectShimmer();
              case Status.error:
                return Center(
                  child: Text(state.subjectList.message.toString()),
                );
              case Status.success:
                return state.subjectList.data!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Subjects Founds!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 20,),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.black,
                                ),
                                onPressed: () async {
                                  await Provider.of<SubjectViewModel>(context,
                                          listen: false)
                                      .getSubjectData();
                                },
                                child:  Text("Reload Data",  style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),))
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return SubjectViewWidget(
                            state: state,
                            index: index,
                          );
                        },
                        itemCount: state.subjectList.data!.length,
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
