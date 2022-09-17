// To parse this JSON data, do
//
//     final songsListModel = songsListModelFromMap(jsonString);

import 'dart:convert';

SongsListModel songsListModelFromMap(String str) => SongsListModel.fromMap(json.decode(str));

String songsListModelToMap(SongsListModel data) => json.encode(data.toMap());

class SongsListModel {
    SongsListModel({
        this.name,
        this.thumbnail,
        this.url,
    });

    String? name;
    String? thumbnail;
    String? url;

    factory SongsListModel.fromMap(Map<String, dynamic> json) => SongsListModel(
        name: json["name"],
        thumbnail: json["thumbnail"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "thumbnail": thumbnail,
        "url": url,
    };
}
