// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_model.g.dart';
part 'subject_model.freezed.dart';

@freezed
abstract class SubjectModel implements _$SubjectModel {
  const SubjectModel._();
  const factory SubjectModel({
    @Default("") String Id,
    @Default("") String Image,
    @Default("") String Title,
  }) = _SubjectModel;

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  static SubjectModel empty() => const SubjectModel(Image: "", Title: "");

  static SubjectModel fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SubjectModel(
        Id: document.id,
        Image: data["Image"] ?? "",
        Title: data["Title"] ?? "",
      );
    } else {
      return empty();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();

    data["Image"] = Image;
    data["Title"] = Title;
    return data;
  }
}
