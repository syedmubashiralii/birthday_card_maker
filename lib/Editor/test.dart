import 'dart:typed_data';

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Editor/edit_photo/edit_photo_page.dart';
import 'package:birthday_app_new/Editor/showimage.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage_2/transition.dart';
import 'package:flutter_advanced_networkimage_2/zoomable.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class Test extends StatefulWidget {
  String img;

  Test({Key? key, required this.img}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  static GlobalKey previewContainer = new GlobalKey();
  final ImagePicker _picker = ImagePicker();
  var _imageFile;
  var imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  _getFromGallery(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 50,
      );
      setState(() {
        imageFile = io.File(pickedFile!.path);
      });
    } catch (e) {}
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: iconButton(
            onTap: () {
              if (index == 0) {
                setState(() {
                  index = 1;
                });
              } else {
                setState(() {
                  index = 0;
                });
              }
            },
            icon: Icons.reset_tv),
        bottomNavigationBar: InkWell(
          onTap: () {
            _getFromGallery(ImageSource.gallery);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0XFF307777),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(36.0),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Text(
              textAlign: TextAlign.center,
              "Pick Image",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0XFF307777),
          title: Text("Frame"),
          actions: [
            InkWell(
                onTap: () async {
                  takescreenshot();
                },
                child: Icon(Icons.done)),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: RepaintBoundary(
            key: previewContainer,
            child: ZoomableWidget(
              minScale: 0.3,
              maxScale: 2.0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: imageFile == null
                    ? BoxDecoration()
                    : BoxDecoration(
                        image: DecorationImage(image: FileImage(imageFile))),
                child: RepaintBoundary(
                  child: Container(
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(image: AssetImage(widget.img))),
                      child: ZoomableWidget(
                          minScale: 0.3,
                          maxScale: 2.0,
                          // default factor is 1.0, use 0.0 to disable boundary
                          panLimit: 0.8,
                          child: imageFile == null ? Container() : Container()
                          // : TransitionToImage(
                          //     fit: BoxFit.cover,
                          //     image: FileImage(imageFile),
                          //     // This is the default placeholder widget at loading status,
                          //     // you can write your own widget with CustomPainter.
                          //     placeholder: CircularProgressIndicator(),
                          //     // This is default duration
                          //     duration: Duration(milliseconds: 300),
                          //   ),
                          )),
                ),
              ),
            )));
  }

  takescreenshot() async {
    RenderRepaintBoundary? boundary = previewContainer.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    //  var image = await screenshotController.capture();

    //   Constants.uint8image = image;
    //                 print(image);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Showimage(Image: pngBytes)));
  }
}
