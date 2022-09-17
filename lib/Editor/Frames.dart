import 'package:birthday_app_new/Editor/image%20picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Frames extends StatefulWidget {
  const Frames({Key? key}) : super(key: key);

  @override
  State<Frames> createState() => _FramesState();
}

class _FramesState extends State<Frames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Frames",
          style: TextStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 3.5,
            mainAxisSpacing: 12.5,
            crossAxisCount: 3,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Get.off(
                      ImagePickerr(img: "assets/frames/frame${index + 1}.png"));
                },
                child: Image.asset("assets/frames/frame${index + 1}.png"));
          },
        ),
      ),
    );
  }
}
