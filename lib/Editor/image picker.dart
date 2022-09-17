// ignore_for_file: must_be_immutable, unused_field, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously

import 'dart:typed_data';

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Editor/edit_photo/edit_photo_page.dart';
import 'package:birthday_app_new/Editor/showimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/transition.dart';
import 'package:flutter_advanced_networkimage_2/zoomable.dart';
import 'package:provider/provider.dart';
import 'package:sticker_view/stickerview.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

import '../BLoC/application_bloc.dart';

class ImagePickerr extends StatefulWidget {
  String img;

  ImagePickerr({Key? key, required this.img}) : super(key: key);

  @override
  State<ImagePickerr> createState() => _ImagePickerrState();
}

class _ImagePickerrState extends State<ImagePickerr> {
  @override
  initState() {
    stickerlist.clear();
  }

  // static GlobalKey previewContainer = GlobalKey();
  final ImagePicker _picker = ImagePicker();

  var _imageFile;
  var imageFile;
  List<Sticker> stickerlist = [];
  ScreenshotController screenshotController = ScreenshotController();
  _getFromGallery(ImageSource source) async {
    try {
      imageFile = null;
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 50,
      );
      setState(() {
        imageFile = io.File(pickedFile!.path);
        stickerlist.add(
          Sticker(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            isText: false,
            child: ZoomableWidget(
                minScale: 0.3, maxScale: 2.0, child: Image.file(imageFile)),
          ),
        );
        // stickerlist.add(
        //   Sticker(
        //     id: "uniqueId_120",
        //     isText: false,
        //     child: Screenshot(
        //         controller: screenshotController,
        //         child: IgnorePointer(
        //             ignoring: true, child: Image.asset(widget.img))),
        //   ),
        // );
      });
    } catch (e) {}
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          // Uint8List? imageData =
          //     await StickerView.saveAsUint8List(ImageQuality.high);
          _getFromGallery(ImageSource.gallery);
        },
        child: Container(
          decoration: const BoxDecoration(
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
        backgroundColor: const Color(0XFF307777),
        title: Text("Frame"),
        actions: [
          InkWell(
              onTap: () async {
                takescreenshot();
              },
              child: const Icon(Icons.done)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Stack(children: [
          StickerView(
              width: double.infinity,
              height: Constants.screenHeight(context) * .6,
              stickerList: stickerlist),
          IgnorePointer(
            ignoring: true,
            child: SizedBox(
                width: double.infinity,
                height: Constants.screenHeight(context) * .6,
                child: Image.asset(
                  widget.img,
                  fit: BoxFit.contain,
                )),
          ),
        ]),
      ),
    );
  }

  takescreenshot() async {
    // RenderRepaintBoundary? boundary = previewContainer.currentContext!
    //     .findRenderObject() as RenderRepaintBoundary?;
    // ui.Image image = await boundary!.toImage();
    // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List pngBytes = byteData!.buffer.asUint8List();

   
    // final applicationBloc = Provider.of<ApplicationBloc>(context,listen: false);
    var image = await screenshotController.capture();
     Navigator.push(context,
        MaterialPageRoute(builder: (context) => Showimage(Image: image)));
    // applicationBloc.updateframe(image);
    print(image);
    Navigator.of(context);
  }
}
