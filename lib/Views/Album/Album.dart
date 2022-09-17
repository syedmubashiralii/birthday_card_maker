// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../Controller/AdsController.dart';
import '../BirthdayReminder/AddReminder.dart';
import 'edit&share.dart';

class ShowAlbum extends StatefulWidget {
  const ShowAlbum({Key? key}) : super(key: key);

  @override
  State<ShowAlbum> createState() => _ShowAlbumState();
}

class _ShowAlbumState extends State<ShowAlbum> {
  bool isloading = true;
  @override
  void initState() {
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.albumbanner();
    isloading = true;
    getData();
    super.initState();
  }

  List<String> allimageslist = [];
  var ImagesPath;
  Directory? dir2;
  void getData() async {
    if (Platform.isAndroid) {
      ImagesPath =
          "/data/user/0/com.example.birthday_app_new/app_flutter/Pictures";
      dir2 = Directory(ImagesPath);
    } else if (Platform.isIOS) {
      var appDir = await getApplicationDocumentsDirectory();
      dir2 = Directory('${appDir.path}/Pictures');
      ImagesPath = '${appDir.path}/Pictures';
    }
    bool directoryExists = await Directory(ImagesPath).exists();
    if (directoryExists) {
      List<FileSystemEntity> files = dir2!.listSync();
      isloading = false;
      setState(() {});
      for (FileSystemEntity f1 in files) {
        allimageslist.add(f1.absolute.path);
      }
    }
    isloading = false;
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<get_ads>(context);
    return Scaffold(
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
          "album".tr,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 20, color: colors.secondarycolor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Background(
          child: isloading == true
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.primarycolor,
                  ),
                )
              : allimageslist.isEmpty
                  ? Center(
                      child: SizedBox(
                        height: 399,
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              color: colors.primarycolor,
                              size: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ncards".tr,
                              style: TextStyle(
                                  fontFamily: "RobotoM",
                                  fontSize: 18,
                                  color: colors.primarycolor),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 12.5,
                        mainAxisSpacing: 12.5,
                        crossAxisCount: 3,
                      ),
                      itemCount: allimageslist.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await EasyLoading.show(
                                status: "Loading",
                                maskType: EasyLoadingMaskType.black,
                                indicator: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: colors.primarycolor,
                                ));

                            if (Constants.isreminder) {
                              Constants.cardpath =
                                  allimageslist[index].toString();
                              Constants.isreminder = false;
                              Get.off(() =>const AddReminder());
                            } else {
                              Get.to(EditandShare(
                                  imagefile: File(allimageslist[index])));
                            }
                          },
                          child: Container(
                            width: Constants.screenWidth(context) * 0.30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image:
                                        FileImage(File(allimageslist[index])),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      })),
      persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, dataa, child) {
            return Container(
              color: dataa.isalbumbanner
                  ? Colors.transparent
                  : Colors.yellow[200],
              height: MediaQuery.of(context).size.height * 0.06,
              child: applicationBloc.isalbumbanner
                  ? AdWidget(ad: dataa.album_banner)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          textAlign: TextAlign.right,
                          "Ad",
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}
