import 'dart:io';
import 'package:birthday_app_new/Editor/Frames.dart';
import 'package:birthday_app_new/Editor/edit_photo/edit_photo_page.dart';
import 'package:birthday_app_new/Editor/texteditor.dart';
import 'package:birthday_app_new/Views/BirthdayReminder/AddReminder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/dialog_widgets.dart';
import '../Widgets/widgets.dart';
import '../Views/BirthdaySongs/Songslist.dart';
import 'image picker.dart';

// ignore: must_be_immutable
class EditorScreen extends StatefulWidget {
  var Img;
  EditorScreen({Key? key, required this.Img}) : super(key: key);

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  FToast? fToast;
  String path = "";
  @override
  initState() {
    EasyLoading.dismiss();
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  void saveImage(BuildContext context) async {
    // final image = await widget.Img.exportImage();
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
    imageFile.writeAsBytes(widget.Img!);
    GallerySaver.saveImage(imageFile.path, albumName: 'Birthday Card')
        .then((value) {
      print("saved");
    });
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F3D7),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
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
              // handle the press
            },
          ),
          SizedBox(
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
              SavePicture(context, () {
                saveImage(context);
                Navigator.pop(context);
                _showToast("Picture stored in Album!");
              }, () {
                saveImage(context);
                Constants.cardpath = path;
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddReminder()));
              });
              //saveImage(context);
              // final image = await widget.Img.exportImage();
              //   final directory = await getApplicationDocumentsDirectory();
              //   final path = directory.path;
              //   final file = await new File(
              //           '$path/${DateTime.now().millisecondsSinceEpoch}.png')
              //       .create();
              //  file.writeAsBytesSync(widget.Img);
              //   GallerySaver.saveImage(file.path, albumName: 'Birthday Card')
              //       .then((value) {
              //     print("saved");
              //   });
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
        elevation: 0,
      ),
      body: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: Constants.screenHeight(context) * 0.14,
              ),
            ),
            Container(
              height: Constants.screenHeight(context) * 0.4,
              width: Constants.screenWidth(context) * 1.0,
              child: Image.memory(
                widget.Img,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                // loadingBuilder: (BuildContext context, Widget child,
                //     ImageChunkEvent? loadingProgress) {
                //   return loadingProgress == null
                //       ? Image.network(Img)
                //       : Center(
                //           child: CircularProgressIndicator(
                //             color: colors.primarycolor,
                //             value: loadingProgress.expectedTotalBytes != null
                //                 ? loadingProgress.cumulativeBytesLoaded /
                //                     loadingProgress.expectedTotalBytes!.toInt()
                //                 : null,
                //           ),
                //         );
                // },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: Constants.screenHeight(context) * 0.15,
              ),
            ),
            Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                            height: 45,
                            width: 45,
                            child: Image.asset("assets/images/animation.png")),
                        Text(
                          "animation".tr,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis)),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SongsList()));
                      },
                      child: Column(
                        children: [
                          Container(
                              height: 45,
                              width: 45,
                              child: Image.asset("assets/images/music.png")),
                          Text(
                            "song".tr,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
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
      
      bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(36.0),
              ),
              color: colors.primarycolor),
          padding: EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
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
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ImagePainterExample(widget.Img)));
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => EditPhotoPage(
                  //               image: widget.Img,
                  //             )));

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TextEditor(
                                img: widget.Img,
                              )));
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Frames()));
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TextEditor(
                                img: widget.Img,
                              )));
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
          Icon(PhosphorIcons.maskHappyLight),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }



  static TextTheme cinzelDecorativeTextTheme([TextTheme? textTheme]) {
  textTheme ??= ThemeData.light().textTheme;
  return TextTheme(
    displayLarge:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.displayLarge),
    displayMedium:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.displayMedium),
    displaySmall:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.displaySmall),
    headlineLarge:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.headlineLarge),
    headlineMedium:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.headlineMedium),
    headlineSmall:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.headlineSmall),
    titleLarge: GoogleFonts.cinzelDecorative(textStyle: textTheme.titleLarge),
    titleMedium:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.titleMedium),
    titleSmall: GoogleFonts.cinzelDecorative(textStyle: textTheme.titleSmall),
    bodyLarge: GoogleFonts.cinzelDecorative(textStyle: textTheme.bodyLarge),
    bodyMedium: GoogleFonts.cinzelDecorative(textStyle: textTheme.bodyMedium),
    bodySmall: GoogleFonts.cinzelDecorative(textStyle: textTheme.bodySmall),
    labelLarge: GoogleFonts.cinzelDecorative(textStyle: textTheme.labelLarge),
    labelMedium:
        GoogleFonts.cinzelDecorative(textStyle: textTheme.labelMedium),
    labelSmall: GoogleFonts.cinzelDecorative(textStyle: textTheme.labelSmall),
  );
}
}
