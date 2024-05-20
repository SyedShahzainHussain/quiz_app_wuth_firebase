// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionsModelImpl _$$QuestionsModelImplFromJson(Map<String, dynamic> json) =>
    _$QuestionsModelImpl(
      question: json['question'] as String? ?? "",
      correctAns: json['correctAns'] as String? ?? "",
      answer: (json['answer'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$QuestionsModelImplToJson(
        _$QuestionsModelImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'correctAns': instance.correctAns,
      'answer': instance.answer,
    };
