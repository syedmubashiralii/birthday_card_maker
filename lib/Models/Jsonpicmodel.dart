// To parse this JSON data, do
//
//     final jsonPicDart = jsonPicDartFromMap(jsonString);

import 'dart:convert';

JsonPicDart jsonPicDartFromMap(String str) => JsonPicDart.fromMap(json.decode(str));

String jsonPicDartToMap(JsonPicDart data) => json.encode(data.toMap());

class JsonPicDart {
    JsonPicDart({
        this.template,
        this.version,
    });

    List<Template>? template;
    String? version;

    factory JsonPicDart.fromMap(Map<String, dynamic> json) => JsonPicDart(
        template: List<Template>.from(json["template"].map((x) => Template.fromMap(x))),
        version: json["version"],
    );

    Map<String, dynamic> toMap() => {
        "template": List<dynamic>.from(template!.map((x) => x.toMap())),
        "version": version,
    };
}

class Template {
    Template({
        this.bkg,
        this.stickers,
        this.shapes,
        this.textviews,
    });

    List<Bkg>? bkg;
    List<dynamic>? stickers;
    List<dynamic>? shapes;
    List<Textview>? textviews;

    factory Template.fromMap(Map<String, dynamic> json) => Template(
        bkg: List<Bkg>.from(json["bkg"].map((x) => Bkg.fromMap(x))),
        stickers: List<dynamic>.from(json["stickers"].map((x) => x)),
        shapes: List<dynamic>.from(json["shapes"].map((x) => x)),
        textviews: List<Textview>.from(json["textviews"].map((x) => Textview.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "bkg": List<dynamic>.from(bkg!.map((x) => x.toMap())),
        "stickers": List<dynamic>.from(stickers!.map((x) => x)),
        "shapes": List<dynamic>.from(shapes!.map((x) => x)),
        "textviews": List<dynamic>.from(textviews!.map((x) => x.toMap())),
    };
}

class Bkg {
    Bkg({
        this.bkg,
    });

    String? bkg;

    factory Bkg.fromMap(Map<String, dynamic> json) => Bkg(
        bkg: json["bkg"],
    );

    Map<String, dynamic> toMap() => {
        "bkg": bkg,
    };
}

class Textview {
    Textview({
        this.text,
        this.textFillType,
        this.textFill,
        this.outlinechk,
        this.textOutlineColor,
        this.font,
        this.style,
        this.size,
        this.scale,
        this.recttop,
        this.rectbottom,
        this.rectleft,
        this.rectright,
        this.rotateAngle,
        this.top,
        this.left,
        this.align,
        this.shadowRadius,
        this.shadowHr,
        this.shadowVr,
        this.bgChk,
        this.bgContenttype,
        this.bgFill,
        this.bgRadius,
        this.bgAlpha,
        this.bgOffsetVr,
        this.bgOffsetHr,
    });

    String? text;
    String? textFillType;
    String? textFill;
    bool? outlinechk;
    int? textOutlineColor;
    String? font;
    int? style;
    int? size;
    double? scale;
    double? recttop;
    double? rectbottom;
    double? rectleft;
    double? rectright;
    double? rotateAngle;
    double? top;
    double? left;
    int? align;
    int? shadowRadius;
    String? shadowHr;
    String? shadowVr;
    bool? bgChk;
    int? bgContenttype;
    int? bgFill;
    int? bgRadius;
    int? bgAlpha;
    int? bgOffsetVr;
    int? bgOffsetHr;

    factory Textview.fromMap(Map<String, dynamic> json) => Textview(
        text: json["text"],
        textFillType: json["text_fill_type"],
        textFill: json["text_fill"],
        outlinechk: json["outlinechk"],
        textOutlineColor: json["text_outline_color"],
        font: json["font"],
        style: json["style"],
        size: json["size"],
        scale: json["scale"].toDouble(),
        recttop: json["recttop"].toDouble(),
        rectbottom: json["rectbottom"].toDouble(),
        rectleft: json["rectleft"].toDouble(),
        rectright: json["rectright"].toDouble(),
        rotateAngle: json["rotate_angle"].toDouble(),
        top: json["top"].toDouble(),
        left: json["left"].toDouble(),
        align: json["align"],
        shadowRadius: json["shadow_radius"],
        shadowHr: json["shadow_hr"],
        shadowVr: json["shadow_vr"],
        bgChk: json["bg_chk"],
        bgContenttype: json["bg_contenttype"],
        bgFill: json["bg_fill"],
        bgRadius: json["bg_radius"],
        bgAlpha: json["bg_alpha"],
        bgOffsetVr: json["bg_offset_vr"],
        bgOffsetHr: json["bg_offset_hr"],
    );

    Map<String, dynamic> toMap() => {
        "text": text,
        "text_fill_type": textFillType,
        "text_fill": textFill,
        "outlinechk": outlinechk,
        "text_outline_color": textOutlineColor,
        "font": font,
        "style": style,
        "size": size,
        "scale": scale,
        "recttop": recttop,
        "rectbottom": rectbottom,
        "rectleft": rectleft,
        "rectright": rectright,
        "rotate_angle": rotateAngle,
        "top": top,
        "left": left,
        "align": align,
        "shadow_radius": shadowRadius,
        "shadow_hr": shadowHr,
        "shadow_vr": shadowVr,
        "bg_chk": bgChk,
        "bg_contenttype": bgContenttype,
        "bg_fill": bgFill,
        "bg_radius": bgRadius,
        "bg_alpha": bgAlpha,
        "bg_offset_vr": bgOffsetVr,
        "bg_offset_hr": bgOffsetHr,
    };
}
