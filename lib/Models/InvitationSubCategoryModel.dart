// To parse this JSON data, do
//
//     final invitationSubCategoryModel = invitationSubCategoryModelFromMap(jsonString);

import 'dart:convert';

InvitationSubCategoryModel invitationSubCategoryModelFromMap(String str) =>
    InvitationSubCategoryModel.fromMap(json.decode(str));

String invitationSubCategoryModelToMap(InvitationSubCategoryModel data) =>
    json.encode(data.toMap());

class InvitationSubCategoryModel {
  InvitationSubCategoryModel({
    this.id,
    this.name,
    this.category,
    required this.templateJsonLink,
    required this.thumbnailLink,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? category;
  String templateJsonLink;
  String thumbnailLink;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory InvitationSubCategoryModel.fromMap(Map<String, dynamic> json) =>
      InvitationSubCategoryModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        templateJsonLink: json["template_json_link"],
        thumbnailLink: json["thumbnail_link"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "template_json_link": templateJsonLink,
        "thumbnail_link": thumbnailLink,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
