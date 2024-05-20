import 'package:quiz_app_with_firebase/admin/view_model/upload_quiz_view_model.dart';
import 'package:quiz_app_with_firebase/config/components/input_field_widget.dart';
import 'package:quiz_app_with_firebase/config/components/rounded_button_widget.dart';
import 'package:quiz_app_with_firebase/config/helper/helper_function.dart';

import 'package:quiz_app_with_firebase/view/subjects/subjects.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  late TextEditingController levelController;
  late TextEditingController questionController;
  late TextEditingController correctAnsController;
  final List<TextEditingController> answerControllers = [];
  final List<FocusNode> answerControllersFocusNode = [];
  late FocusNode levelControllerFocusNode;
  late FocusNode questionControllerFocusNode;
  late FocusNode correctAnsControllerFocusNode;
  String? selectedSubject;

  @override
  void initState() {
    super.initState();
    levelController = TextEditingController();
    questionController = TextEditingController();
    correctAnsController = TextEditingController();
    levelControllerFocusNode = FocusNode();
    questionControllerFocusNode = FocusNode();
    correctAnsControllerFocusNode = FocusNode();
    for (int i = 0; i < 4; i++) {
      FocusNode focusNode = FocusNode();
      TextEditingController controller = TextEditingController();
      controller.addListener(() {
        if (mounted) {
          setState(() {}); // Update the state to reflect changes
        }
      });
      answerControllers.add(controller);
      answerControllersFocusNode.add(focusNode);
    }
  }

  @override
  void dispose() {
    for (var controller in answerControllers) {
      controller.dispose();
    }
    for (var focusNode in answerControllersFocusNode) {
      focusNode.dispose();
    }
    levelController.dispose();
    questionController.dispose();
    levelControllerFocusNode.dispose();
    questionControllerFocusNode.dispose();
    correctAnsControllerFocusNode.dispose();
    super.dispose();
  }

  bool isAnswerFilled(int index) {
    return answerControllers[index].text.isNotEmpty;
  }

  void save() async {
    if (levelController.text.isEmpty ||
        questionController.text.isEmpty ||
        correctAnsController.text.isEmpty ||
        selectedSubject!.isEmpty ||
        answerControllers.any((e) => e.text.isEmpty)) {
      HelperFunction.showSnackbar("Please fill all the fields", context);
    } else {
      await Provider.of<UploadQuizViewModel>(context, listen: false)
          .uploadQuiz(
        level: levelController.text.toLowerCase(),
        question: questionController.text.toLowerCase(),
        correctAns: correctAnsController.text.toLowerCase(),
        context: context,
        answers: answerControllers.map((e) => e.text).toList(),
        subjectTitle: selectedSubject!,
      )
          .then((value) {
        // setState(() {
        //   levelController.clear();
        //   questionController.clear();
        //   correctAnsController.clear();
        //   answerControllers.map((e) => e.clear());
        //   selectedSubject = null;
        // });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Add Quiz",
      ),
      body: LinearGradientWidget(
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              InputField(
                focusNode: levelControllerFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context)
                      .requestFocus(questionControllerFocusNode);
                },
                controller: levelController,
                title: "Level",
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                focusNode: questionControllerFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context)
                      .requestFocus(answerControllersFocusNode[0]);
                },
                controller: questionController,
                title: "Question",
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<SubjectViewModel>(builder: (context, state, _) {
                switch (state.subjectList.status) {
                  case Status.success:
                    return DropdownButtonFormField(
                      value: selectedSubject,
                      hint: Text(
                        "Selected Subjects",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      dropdownColor: AppColors.purple,
                      elevation: 10,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                      menuMaxHeight: 200,
                      items: state.subjectList.data!
                          .map((e) => DropdownMenuItem(
                                value: e.Title,
                                child: Text(e.Title),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value;
                        });
                      },
                    );
                  default:
                    return const SizedBox();
                }
              }),
              const SizedBox(
                height: 20,
              ),
              for (int i = 0; i < 4; i++)
                Visibility(
                  visible: i == 0 || (i > 0 && isAnswerFilled(i - 1)),
                  child: Column(
                    children: [
                      InputField(
                        focusNode: answerControllersFocusNode[i],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (p0) {
                          i < answerControllersFocusNode.length - 1
                              ? FocusScope.of(context).requestFocus(
                                  answerControllersFocusNode[i + 1])
                              : FocusScope.of(context)
                                  .requestFocus(correctAnsControllerFocusNode);
                        },
                        controller: answerControllers[i],
                        title: "Answers ${i + 1}",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              Visibility(
                visible: isAnswerFilled(3),
                child: InputField(
                  focusNode: correctAnsControllerFocusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (p0) {},
                  controller: correctAnsController,
                  title: "Correct Answer",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<UploadQuizViewModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return RoundedButtonWidget(
                    isLoading: value.isLoading,
                    title: "Upload Quiz",
                    onPressed: () {
                      save();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
