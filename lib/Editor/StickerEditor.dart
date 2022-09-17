// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Editor/EditorScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stick_it/stick_it.dart';

class StickerEditor extends StatefulWidget {
  var background;
  StickerEditor({Key? key, required this.background}) : super(key: key);
  @override
  _StickerEditorState createState() => _StickerEditorState();
}

class _StickerEditorState extends State<StickerEditor> {
  late StickIt _stickIt;
  File? _image;
  @override
  Widget build(BuildContext context) {
    _stickIt = StickIt(
      child: Container(
          width: double.infinity,
          child: Image.memory(widget.background, fit: BoxFit.fitWidth)),
      stickerList: [
        Image.network(
          "http://134.209.195.127///img//y27.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y28.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/y27.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/y26.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/y25.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y24.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/y23.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y21.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y20.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y19.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/y18.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y17.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//y16.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y15.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y14.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y13.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y12.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/y11.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y10.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//y9.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y8.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y7.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//y5.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/t32.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/sc26.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc25.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc24.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/sc23.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/sc22.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc21.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/sc20.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc19.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc18.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc17.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/y16.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/y15.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//sc14.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc13.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc12.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc11.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc10.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/sc9.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc8.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//sc7.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc6.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc5.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//sc4.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/sc3.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer109.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//Layer13.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer12.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer10.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer9.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer8.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127//json/Layer7.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer6.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//Layer5.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer4.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer3.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//Layer125.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer124.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer123.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer122.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//Layer77.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer76.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer75.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer74.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer60.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//Layer59.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer58.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//Layer57.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Layer56.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/Emojione_1F389.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127/json/confetti.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Image.network(
          "http://134.209.195.127///img//y7.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ],
      key: UniqueKey(),
      panelHeight: 175,
      panelBackgroundColor: colors.primarycolor,
      panelStickerBackgroundColor: Colors.transparent,
      stickerSize: 100,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primarycolor,
        title: Text("stickers".tr),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              final image = await _stickIt.exportImage();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditorScreen(
                            Img: image,
                          )));
            },
            child: Icon(
              Icons.done,
              color: colors.secondarycolor,
              size: 30,
            ),
          ),
          SizedBox(
            width: 25,
          )
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          _stickIt,
        ],
      ),
    );
  }
}
