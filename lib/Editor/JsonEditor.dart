// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:birthday_app_new/Ads/openads.dart';
import 'package:birthday_app_new/Editor/texteditor.dart';
import 'package:birthday_app_new/Views/Album/Album.dart';
import 'package:birthday_app_new/Views/BirthdayReminder/AddReminder.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../BLoC/application_bloc.dart';
import '../Widgets/dialog_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sticker_view/stickerview.dart';
import '../Views/BirthdaySongs/Songslist.dart';
import 'Frames.dart';

// ignore: must_be_immutable
class JsonEditor extends StatefulWidget {
  var img;
  JsonEditor({Key? key, required this.img}) : super(key: key);

  @override
  State<JsonEditor> createState() => _JsonEditorState();
}

class _JsonEditorState extends State<JsonEditor> with WidgetsBindingObserver {
  bool issharebutton = false;
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;
  var shape = [];
  var frame = [];
  var content_fill = [];
  var sticker = [];
  var imageData;
  var _base64;
  var bytes;
  var text;
  var stickers;
  var parseframe;
  var shapes;
  List color = [];
  bool loading = true;
  var ress = [];
  late Map<String, dynamic> map;
  late Map<String, dynamic> bkg;
  FToast? fToast;
  String path = "";
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused && issharebutton) {
      print("Resumed==========================");
      appOpenAdManager.showAdIfAvailable();
      isPaused = false;
      issharebutton = false;
    }
  }

  @override
  initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.editorloading = true;
    Constants.stickerlist.clear();
    appOpenAdManager.loadAd();
    loading = true;
    EasyLoading.dismiss();
    if (Constants.iseditingmode) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => pasre(),
      );
    } else {
      if (Constants.isjson) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => getimg(widget.img),
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => pasre(),
        );
      }
    }
    super.initState();
  }

  pasre() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    getxdialog(colors.primarycolor, colors.primarycolor, colors.secondarycolor);
    if (Constants.iseditingmode) {
      imageData = widget.img;
      Future.delayed(const Duration(seconds: 2), () {
        print('One second has passed.');
        Get.back(); // Prints after 1 second.
      });
      applicationBloc.editorload();
      // loading = false;
      // setState(() {});
    } else {
      imageData =
          (await NetworkAssetBundle(Uri.parse(widget.img)).load(widget.img))
              .buffer
              .asUint8List();
      applicationBloc.editorload();
      // loading = false;
      // setState(() {});
      Future.delayed(const Duration(seconds: 2), () {
        print('One second has passed.');
        Get.back(); // Prints after 1 second.
      });
    }
  }

  getimg(String img) async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    getxdialog(colors.primarycolor, colors.primarycolor, colors.secondarycolor);
    print("entered");
    http.Response response = await http.get(
      Uri.parse(img),
    );
    print("statuscode");
    if (response.statusCode == 200) {
      print("ok");
      map = json.decode(response.body);
      //log(map.toString());
      print("parsing");
      List<dynamic> data = map["template"];
      // print(data[0]["bkg"][0].toString());
      _base64 = data[0]["bkg"][0]["bkg"];
      text = data[0]["textviews"];
      stickers = data[0]["stickers"];
      shapes = data[0]["shapes"];
      final bgimgbytes =
          base64.normalize((_base64.replaceAll(RegExp(r'\s+'), '')));
      // final bytes = const Base64Decoder().convert(_base64.replaceAll(RegExp(r'\s+'), ''));
      // bytes = base64.decode(_base64.replaceAll(RegExp(r'\s+'), ''));
      bytes = base64.decode(bgimgbytes);
      // log(bytes.toString());

      print("building list");
      // for (int i = 0; i < shapes.length; i++) {
      //   parseframe = shapes[i]["frame"];
      //   final bytess =
      //       base64.normalize((parseframe.replaceAll(RegExp(r'\s+'), '')));
      //   var bytes = base64.decode(bytess);
      //   frame.add(bytes);
      //   stickerlist.add(
      //     Sticker(
      //       id: "uniqueId_$i 01234567",
      //       isText: false,
      //       child: Padding(
      //         padding: EdgeInsets.only(
      //           top: double.parse(shapes[i]["top"].toString()),
      //           left: double.parse(shapes[i]["left"].toString()),
      //           right: double.parse(shapes[i]["right"].toString()),
      //           bottom: double.parse(shapes[i]["bottom"].toString()),
      //         ),
      //         child: Image.memory(frame[i]),
      //       ),
      //     ),
      //   );
      // }
      // for (int i = 0; i < shapes.length; i++) {
      //   var parsemask = shapes[i]["mask"];
      //   final bytess =
      //       base64.normalize((parsemask.replaceAll(RegExp(r'\s+'), '')));
      //   var bytes = base64.decode(bytess);
      //   shape.add(bytes);
      //   stickerlist.add(
      //     Sticker(
      //       id: "uniqueId_$i 01134",
      //       isText: false,
      //       child: Padding(
      //         padding: EdgeInsets.only(
      //           top: double.parse(shapes[i]["top"].toString()),
      //           left: double.parse(shapes[i]["left"].toString()),
      //           right: double.parse(shapes[i]["right"].toString()),
      //           bottom: double.parse(shapes[i]["bottom"].toString()),
      //         ),
      //         child: Image.memory(shape[i]),
      //       ),
      //     ),
      //   );
      // }
      for (int i = 0; i < text.length; i++) {
        color.add("0xff${text[i]["text_fill"]}");
      }
      for (int i = 0; i < shapes.length; i++) {
        shape = [];
        var parseshape = shapes[i]["content_fill"];
        final bytesss =
            base64.normalize((parseshape.replaceAll(RegExp(r'\s+'), '')));
        var byteshape = base64.decode(bytesss);
        content_fill.add(byteshape);
        Constants.stickerlist.add(
          Sticker(
            id: "$i${DateTime.now().millisecondsSinceEpoch.toString()}",
            isText: false,
            child: Container(
              margin: EdgeInsets.only(
                top: double.parse(shapes[i]["top"].toString()),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: double.parse(shapes[i]["top"].toString()),
                  left: double.parse(shapes[i]["left"].toString()),
                  right: double.parse(shapes[i]["right"].toString()),
                  bottom: double.parse(shapes[i]["bottom"].toString()),
                ),
                child: Image.memory(
                  content_fill[i],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      }
      for (int i = 0; i < stickers.length; i++) {
        var parsesticker = stickers[i]["img"];
        final stickerbyte =
            base64.normalize((parsesticker.replaceAll(RegExp(r'\s+'), '')));
        var byteshape = base64.decode(stickerbyte);
        sticker.add(byteshape);
        Constants.stickerlist.add(
          Sticker(
            id: "$i${DateTime.now().millisecondsSinceEpoch.toString()}",
            isText: false,
            child: Image.memory(sticker[i]),
          ),
        );
      }
      for (int i = 0; i < text.length; i++) {
        Constants.stickerlist.add(
          Sticker(
            id: "$i${DateTime.now().millisecondsSinceEpoch.toString()}",
            isText: false,
            child: Padding(
              padding: EdgeInsets.only(
                top: double.parse(text[i]["top"].toString()),
                left: double.parse(text[i]["left"].toString()),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: double.parse(text[i]["recttop"].toString()),
                  left: double.parse(text[i]["rectleft"].toString()),
                  right: double.parse(text[i]["rectright"].toString()),
                  bottom: double.parse(text[i]["rectbottom"].toString()),
                ),
                child: Text(
                  // textAlign: TextAlign.left,
                  text[i]["text"],
                  style: i == 0
                      ? GoogleFonts.happyMonkey(
                          fontSize: 13,
                          color: Color(int.parse(color[i])),
                        )
                      : GoogleFonts.maidenOrange(
                          fontSize: 24,
                          color: Color(int.parse(color[i])),
                        ),

                  // fontSize: double.tryParse(
                  //   text[i]["size"].toString(),)
                ),
              ),
            ),
          ),
        );
      }
      applicationBloc.editorload();
      // loading = false;
      // setState(() {});
      Future.delayed(const Duration(seconds: 2), () {
        print('One second has passed.');
        Get.back(); // Prints after 1 second.
      });
    } else {
      print("Error!!");
    }
  }

  saveImage(BuildContext context) async {
    var imagedata = await screenshotController.capture();
    Constants.uint8image = imagedata;
    Directory? directory = await getApplicationDocumentsDirectory();

    bool directoryExists =
        await Directory('${directory.path}/Pictures').exists();

    if (!directoryExists) {
      print("\n Directory not exist");
      //  navigateToShowPage(path, -1);
      await Directory('${directory.path}/Pictures').create(recursive: true);
    }

    print("\n direcctoryb = ${directory}");
    final fullPath =
        '${directory.path}/Pictures/${DateTime.now().millisecondsSinceEpoch}.png';
    File imageFile = File(fullPath);
    path = fullPath;
    Constants.cardpath = fullPath;
    imageFile.writeAsBytes(imagedata!);
    GallerySaver.saveImage(imageFile.path, albumName: 'Birthday Card')
        .then((value) {
      print("saved");
    });
    Constants.showToast("Success");
    EasyLoading.dismiss();
  }

  void shareimage(BuildContext context) async {
    var imagedata = await screenshotController.capture();
    Constants.uint8image = imagedata;
    Directory? directory = await getApplicationDocumentsDirectory();

    bool directoryExists = await Directory('${directory.path}/share').exists();

    if (!directoryExists) {
      print("\n Directory not exist");
      //  navigateToShowPage(path, -1);
      await Directory('${directory.path}/share').create(recursive: true);
    }

    print("\n direcctoryb = ${directory}");
    final fullPath =
        '${directory.path}/share/${DateTime.now().millisecondsSinceEpoch}.png';
    File imageFile = File(fullPath);
    imageFile.writeAsBytes(imagedata!);
    EasyLoading.dismiss();
    Constants.cardpath = imageFile.path;
    var pathh = imageFile.path;
    Share.shareFiles([pathh],
        text: 'Courtesy of Birthday Card Maker\nhttp://bit.ly/2O1cGoS');
    EasyLoading.dismiss();
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF9F3D7),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Constants.isjson = false;
            Navigator.pop(context);
          },
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 15, bottom: 15, right: 8),
              child: Image.asset(
                "assets/images/arrow.png",
                fit: BoxFit.contain,
              )),
        ),
        backgroundColor: colors.primarycolor,
        title: Text(
          "ceditor".tr,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 22, color: colors.secondarycolor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: colors.secondarycolor,
              size: 30,
            ),
            tooltip: 'Share',
            onPressed: () async {
              await EasyLoading.show();
              issharebutton = true;
              shareimage(context);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(
              Icons.save,
              size: 30,
              color: colors.secondarycolor,
            ),
            tooltip: 'Save',
            onPressed: () async {
              SavePicture(context, () async {
                await EasyLoading.show();
                await saveImage(context);
                Navigator.pop(context);
                Get.off(const ShowAlbum());
              }, () async {
                await saveImage(context);
                Navigator.pop(context);
                Get.off(const AddReminder());
              });
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Constants.screenHeight(context) * 0.05,
            ),
            Screenshot(
              controller: screenshotController,
              child: Stack(children: [
                applicationBloc.editorloading == true
                    ? const Center()
                    : SizedBox(
                        width: double.infinity,
                        height: Constants.screenHeight(context) * .6,
                        child: Constants.isjson
                            ? Image.memory(
                                bytes,
                                fit: BoxFit.contain,
                              )
                            : Image.memory(
                                imageData,
                                fit: BoxFit.fill,
                              )),
                StickerView(
                    width: double.infinity,
                    height: Constants.screenHeight(context) * .6,
                    stickerList: Constants.stickerlist),
              ]),
            ),
            SizedBox(
              height: Constants.screenHeight(context) * 0.08,
            ),
            SizedBox(
                height: Constants.screenHeight(context) * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        underCostruction(context);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                              height: Constants.screenHeight(context) * 0.06,
                              width: Constants.screenHeight(context) * 0.06,
                              child:
                                  Image.asset("assets/images/animation.png")),
                          Text(
                            "animation".tr,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis)),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SongsList()));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                              height: Constants.screenHeight(context) * 0.06,
                              width: Constants.screenHeight(context) * 0.06,
                              child: Image.asset("assets/images/music.png")),
                          Text(
                            "song".tr,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis)),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(36.0),
              ),
              color: colors.primarycolor),
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  underCostruction(context);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.cake,
                      color: colors.secondarycolor,
                      size: 30,
                    ),
                    Text(
                      "cake".tr,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: colors.secondarycolor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis)),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  var _textFieldController = TextEditingController();
                  _displayTextInputDialog(context, () {
                    applicationBloc.updatetext(
                        _textFieldController.text, colors.editingtextcolor);
                    Navigator.pop(context);
                  }, _textFieldController);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.title,
                      color: colors.secondarycolor,
                      size: 30,
                    ),
                    Text(
                      "text".tr,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: colors.secondarycolor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis)),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // underCostruction(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const Frames()));
                  Get.to(const Frames());
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.filter_frames_rounded,
                      color: colors.secondarycolor,
                      size: 30,
                    ),
                    Text(
                      "frame".tr,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: colors.secondarycolor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis)),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  final imageLink = await showDialog<String>(
                      context: context,
                      builder: (context) => SelectStickerImageDialog(
                            imagesLinks: Constants.imageLinks,
                          ));
                  if (imageLink == null) return;
                  applicationBloc.updatestickers(imageLink);
                },
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.star_circle,
                      color: colors.secondarycolor,
                      size: 30,
                    ),
                    Text(
                      "stickers".tr,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: colors.secondarycolor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis)),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(PhosphorIcons.maskHappyLight),
          const SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    // fToast!.showToast(
    //   child: toast,
    //   gravity: ToastGravity.TOP,
    //   toastDuration: const Duration(seconds: 2),
    // );
  }

  takeScreenShot() async {
    var img = screenshotController.captureAsUiImage(pixelRatio: 1).asStream();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TextEditor(img: img)));
  }

  Future<void> _displayTextInputDialog(BuildContext context, VoidCallback ontap,
      TextEditingController cont) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Icon(Icons.text_fields),
            content: FractionallySizedBox(
                heightFactor: 0.5,
                child: SingleChildScrollView(
                    child: Wrap(children: [
                  TextField(
                    onChanged: (value) {},
                    controller: cont,
                    decoration: const InputDecoration(hintText: "Enter Text"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (final color in Constants.textcolor)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            colors.editingtextcolor = color;
                          },
                          child: FractionallySizedBox(
                            widthFactor: 1 / 4,
                            child: CircleAvatar(backgroundColor: color),
                          )),
                    ),
                  for (final font in Constants.fontlist)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25, left: 18.0, right: 18, bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Constants.fontfamily = font;
                        },
                        child: Text(
                          font,
                          style: TextStyle(fontFamily: font),
                        ),
                      ),
                    ),
                ]))),
            actions: [
              TextButton(
                onPressed: ontap,
                child: const Text("Ok"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
