import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
class QuestionsModel with _$QuestionsModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory QuestionsModel({
    @Default("") String question,
    @Default("") String correctAns,
    @Default([]) List<String> answer,
  }) = _QuestionsModel;

  factory QuestionsModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionsModelFromJson(json);
}
