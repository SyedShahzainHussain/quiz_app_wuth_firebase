import 'package:quiz_app_with_firebase/config/dialog/locked_dialog.dart';
import 'package:quiz_app_with_firebase/config/helper/helper_function.dart';
import 'package:quiz_app_with_firebase/view/quiz/quiz_screen.dart';
import 'package:quiz_app_with_firebase/view_model/unlocked_level_view_model.dart';

import '../level.dart';

class LevelViewWidget extends StatefulWidget {
  final QuizViewModel state;
  final int index;
  const LevelViewWidget({
    super.key,
    required this.index,
    required this.state,
  });

  @override
  State<LevelViewWidget> createState() => _LevelViewWidgetState();
}

class _LevelViewWidgetState extends State<LevelViewWidget> {
  @override
  void initState() {
    super.initState();
    // Unlock level 0 if index is 0
    if (widget.index == 0) {
      _unlockLevel();
    }
  }

  Future<void> _unlockLevel() async {
    final unlockedLevelsModel =
        Provider.of<UnlockedLevelsModel>(context, listen: false);
    await unlockedLevelsModel
        .unlockLevel(widget.state.quizList.data![widget.index].id);
  }

  @override
  Widget build(BuildContext context) {
    final isUnlocked = context.select<UnlockedLevelsModel, bool>((value) =>
        value.isLevelUnlocked(widget.state.quizList.data![widget.index].id));
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 6.0,
        top: 5.0,
      ),
      child: Card(
        elevation: 4,
        child: GestureDetector(
          onTap: () {
            if (!isUnlocked) {
              LockedDialog.showLockedDialog(context);
            } else if (widget
                .state.quizList.data![widget.index].questions.isEmpty) {
              HelperFunction.showSnackbar(
                  "No questions available for this level.", context);
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      questions:
                          widget.state.quizList.data![widget.index].questions,
                      levelId: widget.state.quizList.data![widget.index].level,
                      index: widget.index,
                      state: widget.state,
                    ),
                  ));
            }
          },
          child: ClipRRect(
            child: Container(
                color: const Color(0xffffffff),
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xffedeeee),
                    child: isUnlocked
                        ? const Icon(Icons.lock_open_outlined)
                        : const Icon(Icons.lock),
                  ),
                  title: Text(
                    "Level: ${widget.state.quizList.data![widget.index].level}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: const Color(0xff030605),
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
