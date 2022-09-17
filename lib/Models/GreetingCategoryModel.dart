// To parse this JSON data, do
//
//     final personalCategoryModel = personalCategoryModelFromMap(jsonString);

import 'dart:convert';

PersonalCategoryModel personalCategoryModelFromMap(String str) => PersonalCategoryModel.fromMap(json.decode(str));

String personalCategoryModelToMap(PersonalCategoryModel data) => json.encode(data.toMap());

class PersonalCategoryModel {
    PersonalCategoryModel({
        this.name,
        this.categoryThumbnail,
        this.subcategoryCards,
        this.subcategoryCakes,
    });

    String? name;
    String? categoryThumbnail;
    String? subcategoryCards;
    String? subcategoryCakes;

    factory PersonalCategoryModel.fromMap(Map<String, dynamic> json) => PersonalCategoryModel(
        name: json["name"],
        categoryThumbnail: json["category_thumbnail"],
        subcategoryCards: json["Subcategory_Cards"],
        subcategoryCakes: json["Subcategory_Cakes"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "category_thumbnail": categoryThumbnail,
        "Subcategory_Cards": subcategoryCards,
        "Subcategory_Cakes": subcategoryCakes,
    };
}
