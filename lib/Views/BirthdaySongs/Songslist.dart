import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Models/SongsModel.dart';
import 'package:birthday_app_new/Views/BirthdaySongs/MusicPlayer.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../BLoC/application_bloc.dart';
import '../../Controller/AdsController.dart';
import '../../Widgets/dialog_widgets.dart';

class SongsList extends StatefulWidget {
  const SongsList({Key? key}) : super(key: key);

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  List<dynamic> data = [];
  List<SongsListModel> songs = [];
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getsongs(),
    );
    getads();
    EasyLoading.dismiss();
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.createBackInterstitialad();
    super.initState();
  }

  _getsongs() async {
    getxdialog(
        colors.songslistcolor, colors.songslistcolor, colors.secondarycolor);
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 100), () {});
    data = await applicationBloc.getsongs();
    songs = [];
    for (var items in data) {
      songs.add(SongsListModel.fromMap(items));
    }
    Future.delayed(const Duration(seconds: 3), () {
      Get.back(); // Prints after 1 second.
    });
  }

  getads() {
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.createBackInterstitialad();
    applicationBloc.Songslistbanner();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final ads = Provider.of<get_ads>(context);
    return Scaffold(
      backgroundColor: Color(0xffF9F3D7),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            ads.showbackinterstitial();
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pop(context);
            });
          },
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 15, bottom: 15, right: 8),
              child: Image.asset(
                "assets/images/arrow.png",
                fit: BoxFit.contain,
              )),
        ),
        backgroundColor: colors.songappbarcolor,
        title: Text(
          "songappbar".tr,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 22, color: colors.secondarycolor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Background(
          child: applicationBloc.loading
              ? Container(
                  height: Constants.screenHeight(context) * 0.59,
                  child: Center(
                      child: CupertinoActivityIndicator(
                    color: colors.songslistcolor,
                    radius: 20,
                  )))
              : Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await EasyLoading.show();
                            Constants.Songurl = songs[index].url.toString();
                            Get.to(Musicpayer(
                                name: songs[index].name.toString(),
                                audiourl: songs[index].url.toString(),
                                thumbnail: songs[index].thumbnail.toString()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 12, bottom: 12),
                            height: 85,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: colors.songslistcolor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              songs[index].thumbnail.toString(),
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: colors.secondarycolor,
                                                strokeWidth: 2.0,
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          songs[index].name.toString(),
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: "Roboto",
                                              color: colors.secondarycolor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: colors.secondarycolor,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          size: 28,
                                          color: colors.songslistcolor,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      }),
                )),
      persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, data, child) {
            return Container(
              color: data.issongslistbanner ? Colors.white : Colors.yellow[200],
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.06,
              child: data.issongslistbanner == true
                  ? AdWidget(ad: data.songslist_banner)
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
        // // Icon(Icons.exit_to_app),
        //  SizedBox(width: 10,),
      ],
    );
  }
}
