// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuestionsModel _$QuestionsModelFromJson(Map<String, dynamic> json) {
  return _QuestionsModel.fromJson(json);
}

/// @nodoc
mixin _$QuestionsModel {
  String get question => throw _privateConstructorUsedError;
  String get correctAns => throw _privateConstructorUsedError;
  List<String> get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestionsModelCopyWith<QuestionsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionsModelCopyWith<$Res> {
  factory $QuestionsModelCopyWith(
          QuestionsModel value, $Res Function(QuestionsModel) then) =
      _$QuestionsModelCopyWithImpl<$Res, QuestionsModel>;
  @useResult
  $Res call({String question, String correctAns, List<String> answer});
}

/// @nodoc
class _$QuestionsModelCopyWithImpl<$Res, $Val extends QuestionsModel>
    implements $QuestionsModelCopyWith<$Res> {
  _$QuestionsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAns = null,
    Object? answer = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAns: null == correctAns
          ? _value.correctAns
          : correctAns // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionsModelImplCopyWith<$Res>
    implements $QuestionsModelCopyWith<$Res> {
  factory _$$QuestionsModelImplCopyWith(_$QuestionsModelImpl value,
          $Res Function(_$QuestionsModelImpl) then) =
      __$$QuestionsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, String correctAns, List<String> answer});
}

/// @nodoc
class __$$QuestionsModelImplCopyWithImpl<$Res>
    extends _$QuestionsModelCopyWithImpl<$Res, _$QuestionsModelImpl>
    implements _$$QuestionsModelImplCopyWith<$Res> {
  __$$QuestionsModelImplCopyWithImpl(
      _$QuestionsModelImpl _value, $Res Function(_$QuestionsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAns = null,
    Object? answer = null,
  }) {
    return _then(_$QuestionsModelImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAns: null == correctAns
          ? _value.correctAns
          : correctAns // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value._answer
          : answer // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$QuestionsModelImpl implements _QuestionsModel {
  const _$QuestionsModelImpl(
      {this.question = "",
      this.correctAns = "",
      final List<String> answer = const []})
      : _answer = answer;

  factory _$QuestionsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionsModelImplFromJson(json);

  @override
  @JsonKey()
  final String question;
  @override
  @JsonKey()
  final String correctAns;
  final List<String> _answer;
  @override
  @JsonKey()
  List<String> get answer {
    if (_answer is EqualUnmodifiableListView) return _answer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answer);
  }

  @override
  String toString() {
    return 'QuestionsModel(question: $question, correctAns: $correctAns, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionsModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAns, correctAns) ||
                other.correctAns == correctAns) &&
            const DeepCollectionEquality().equals(other._answer, _answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, question, correctAns,
      const DeepCollectionEquality().hash(_answer));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionsModelImplCopyWith<_$QuestionsModelImpl> get copyWith =>
      __$$QuestionsModelImplCopyWithImpl<_$QuestionsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionsModelImplToJson(
      this,
    );
  }
}

abstract class _QuestionsModel implements QuestionsModel {
  const factory _QuestionsModel(
      {final String question,
      final String correctAns,
      final List<String> answer}) = _$QuestionsModelImpl;

  factory _QuestionsModel.fromJson(Map<String, dynamic> json) =
      _$QuestionsModelImpl.fromJson;

  @override
  String get question;
  @override
  String get correctAns;
  @override
  List<String> get answer;
  @override
  @JsonKey(ignore: true)
  _$$QuestionsModelImplCopyWith<_$QuestionsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
