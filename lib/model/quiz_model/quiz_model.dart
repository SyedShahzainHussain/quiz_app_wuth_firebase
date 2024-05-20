import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app_with_firebase/model/quesions/question_model.dart';

part 'quiz_model.freezed.dart';
part 'quiz_model.g.dart';

@freezed
class QuizModel with _$QuizModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory QuizModel({
    @Default("") String id,
    @Default("") String level,
    @Default([]) List<QuestionsModel> questions,
  }) = _QuizModel;

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  static QuizModel empty() => const QuizModel(level: "", questions: []);

  static QuizModel fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return QuizModel(
        id: document.id,
        level: data["level"] ?? "",
        questions: (data["questions"] as List<dynamic>?)
                ?.map((e) => QuestionsModel.fromJson(e))
                .toList() ??
            [],
      );
    } else {
      return empty();
    }
  }
}
