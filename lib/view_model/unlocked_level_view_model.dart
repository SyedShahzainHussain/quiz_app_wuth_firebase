import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnlockedLevelsModel extends ChangeNotifier {
  late Map<String, bool> _unlockedLevels;

  UnlockedLevelsModel() {
    _unlockedLevels = {};
    loadUnlockedLevels();
  }

  Future<void> loadUnlockedLevels() async {
    final prefs = await SharedPreferences.getInstance();

    final unlockedLevels = prefs.getStringList('unlocked_levels') ?? [];

    _unlockedLevels = {for (var levelId in unlockedLevels) levelId: true};
    notifyListeners();
  }

  Future<void> unlockLevel(String levelId) async {
    if (_unlockedLevels.containsKey(levelId)) {
      // Level ID already unlocked, do nothing
      return;
    }
    _unlockedLevels[levelId] = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('unlocked_levels', _unlockedLevels.keys.toList());
    notifyListeners();
  }

  bool isLevelUnlocked(String levelId) {
    return _unlockedLevels[levelId] ?? false;
  }
}

//  Map<String, bool> _unlockedLevels = {};

//   Future<void> loadUnlockedLevels() async {
//     final prefs = await SharedPreferences.getInstance();
//     final quizId = widget.state.quizList.data![widget.index].id;
//     final key = 'unlocked_levels_$quizId';
//     final unlockedLevels = prefs.getStringList(key) ?? [];

//     setState(() {
//       _unlockedLevels = {
//         quizId: unlockedLevels.isNotEmpty && unlockedLevels.first == 'true'
//       };
//     });
//   }

//   Future<void> unlockLevel(String quizId) async {
//     setState(() {
//       _unlockedLevels[quizId] = true;
//     });

//     final prefs = await SharedPreferences.getInstance();
//     final key = 'unlocked_levels_$quizId}';
//     final unlockedLevels =
//         _unlockedLevels.entries.map((entry) => entry.value.toString()).toList();

//     await prefs.setStringList(key, unlockedLevels);
//   }