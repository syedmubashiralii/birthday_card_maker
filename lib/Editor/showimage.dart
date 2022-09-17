import 'dart:typed_data';
import 'package:birthday_app_new/Editor/JsonEditor.dart';
import 'package:sticker_view/stickerview.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:flutter/material.dart';
import 'edit_photo/edit_photo_page.dart';

class Showimage extends StatefulWidget {
  Uint8List? Image;
  Showimage({Key? key, this.Image}) : super(key: key);

  @override
  State<Showimage> createState() => _ShowimageState();
}

class _ShowimageState extends State<Showimage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: iconButton(
          onTap: () {
            Constants.stickerlist.add(
              Sticker(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                isText: false,
                child: Image.memory(widget.Image!),
              ),
            );
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => JsonEditor(img: Constants.jsonpath)));
          },
          icon: Icons.done),
      body: Center(
        child: Image.memory(widget.Image!),
      ),
    );
  }
}
