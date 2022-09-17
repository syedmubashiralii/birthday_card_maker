import 'dart:typed_data';
import 'package:birthday_app_new/Editor/edit_photo/cubit/edit_photo_cubit.dart';
import 'package:birthday_app_new/Editor/edit_photo/view/base_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

class EditPhotoView extends StatelessWidget {
  Uint8List image;
  ScreenshotController screenshotController = ScreenshotController();
  EditPhotoView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPhotoCubit, EditPhotoState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.passthrough,
          children: [
            BasePhoto(
              image: image,
            ),
            Screenshot(controller: screenshotController, child: EditLayer()),
          ],
        );
      },
    );
  }
}

class EditLayer extends StatelessWidget {
  const EditLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPhotoCubit, EditPhotoState>(
      buildWhen: (p, c) {
        final changeOnWidgets = p.widgets.length != c.widgets.length;
        final editedWidget = p.widgetState != c.widgetState;
        final editedLayer = p.layerOpacity != c.layerOpacity;
        return changeOnWidgets || editedWidget || editedLayer;
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(state.layerOpacity),
              ),
            ),

            /// widgets
            for (var i = 0; i < state.widgets.length; i++)
              Align(
                key: UniqueKey(),
                alignment: Alignment.center,
                child: state.widgets[i],
              ),
          ],
        );
      },
    );
  }
}
