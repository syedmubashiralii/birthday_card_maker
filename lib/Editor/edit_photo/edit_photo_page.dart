import 'dart:typed_data';

import 'package:birthday_app_new/Editor/edit_photo/view/base_photo.dart';
import 'package:birthday_app_new/Editor/edit_photo/view/edit_photo_view.dart';
import 'package:birthday_app_new/Editor/edit_photo/widget/dragable_widget.dart';
import 'package:birthday_app_new/Widgets/dialog_widgets.dart';
import 'package:birthday_app_new/enums/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import '../EditorScreen.dart';
import 'cubit/edit_photo_cubit.dart';
import 'menu/add text/add_text_page.dart';
import 'menu/delete_text/delete_text_dialog.dart';

class EditPhotoPage extends StatelessWidget {
  Uint8List image;
  EditPhotoPage({Key? key, required this.image}) : super(key: key);

  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPhotoCubit(image),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            BlocListener<EditPhotoCubit, EditPhotoState>(
              listener: (context, state) {
                if (state.statusDownload == StatusDownload.downloading) {
                  showDialogLoading(context);
                }

                if (state.statusDownload == StatusDownload.success) {
                  /// close loading dialog
                  Navigator.pop(context);
                  showInfoDialog(
                    context,
                    "Saved",
                    Icons.check_circle_outline_rounded,
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                }

                if (state.statusDownload == StatusDownload.failed) {
                  /// close loading dialog
                  Navigator.pop(context);

                  showInfoDialog(
                    context,
                    "Failed",
                    Icons.info_outline,
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                }

                if (state.statusShare == StatusDownload.downloading) {
                  showDialogLoading(context);
                }

                if (state.statusShare == StatusDownload.success) {
                  /// close loading dialog
                  Navigator.pop(context);
                }

                if (state.statusShare == StatusDownload.failed) {
                  /// close loading dialog
                  Navigator.pop(context);

                  showInfoDialog(
                    context,
                    "Failed",
                    Icons.info_outline,
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                }
              },
              listenWhen: (p, c) {
                final downloading = p.statusDownload != c.statusDownload;
                final sharing = p.statusShare != c.statusShare;

                return downloading || sharing;
              },
              child: Screenshot(
                controller: screenshotController,
                child: EditPhotoView(
                  image: image,
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: MediaQuery.of(context).padding.top + 20,
              child: BlocBuilder<EditPhotoCubit, EditPhotoState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.widgetState != WidgetState.editing,
                    maintainState: true,
                    child: iconButton(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      icon: Icons.arrow_back_ios_new_rounded,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: 20,
              top: MediaQuery.of(context).padding.top + 20,
              child: BlocBuilder<EditPhotoCubit, EditPhotoState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.widgetState != WidgetState.editing,
                    maintainState: true,
                    child: MenuAction(
                      screenshotController: screenshotController,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 20,
              top: MediaQuery.of(context).padding.top + 70,
              bottom: 80,
              child: RotatedBox(
                quarterTurns: 3,
                child: BlocBuilder<EditPhotoCubit, EditPhotoState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state.layerState == LayerState.editing,
                      maintainState: true,
                      child: Slider(
                        value: state.layerOpacity,
                        min: 0,
                        max: 1,
                        onChanged: context
                            .read<EditPhotoCubit>()
                            .updateLayerTrasparancy,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: BlocBuilder<EditPhotoCubit, EditPhotoState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.widgetState != WidgetState.editing,
                    maintainState: true,
                    child: const MenuEdit(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget iconButton({
  required Function() onTap,
  required IconData icon,
  double iconSize = 32,
  double buttonSize = 54,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: buttonSize,
      width: buttonSize,
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize,
      ),
    ),
  );
}

class MenuAction extends StatelessWidget {
  const MenuAction({
    Key? key,
    required this.screenshotController,
  }) : super(key: key);

  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        iconButton(
          icon: Icons.done,
          onTap: () async {
            context
                .read<EditPhotoCubit>()
                .changeDownloadState(StatusDownload.downloading);
            var image = await screenshotController.capture();

            if (image == null) {
              context
                  .read<EditPhotoCubit>()
                  .changeDownloadState(StatusDownload.failed);

              return;
            }

            context.read<EditPhotoCubit>().downloadImage(image, context);
          },
        ),
        const SizedBox(width: 10),
        iconButton(
          icon: Icons.share,
          onTap: () async {
            var image = await screenshotController.capture();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditorScreen(
                          Img: image,
                        )));
          },
        ),
      ],
    );
  }
}

class MenuEdit extends StatelessWidget {
  const MenuEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        iconButton(
          icon: Icons.layers,
          onTap: context.read<EditPhotoCubit>().editLayer,
        ),
        const SizedBox(width: 10),
        iconButton(
          icon: Icons.text_fields_rounded,
          onTap: () async {
            /// change state to editing
            /// so the menu UI will not visible while add/edit text
            context
                .read<EditPhotoCubit>()
                .changeWidgetState(WidgetState.editing);

            /// wait for text edit done / cancel
            final result = await addText(context) as DragableWidgetTextChild?;

            /// change state to idle
            /// so the menu UI will visible again
            context.read<EditPhotoCubit>().changeWidgetState(WidgetState.idle);

            /// if user cancel add/edit text do nothing
            if (result == null) return;

            /// unique key for identification in List<DragableWidget> on BLocState
            final uniqueKey = DateTime.now().millisecondsSinceEpoch;

            /// define dragable widget abse on results
            final widget = DragableWidget(
              key: UniqueKey(),
              uniqueKey: uniqueKey,
              child: result,
              onTap: (key, child) async {
                /// check if the child is [DragableWidgetTextChild]
                if (child is DragableWidgetTextChild) {
                  /// change state to editing
                  /// so the menu UI will not visible while add/edit text
                  context
                      .read<EditPhotoCubit>()
                      .changeWidgetState(WidgetState.editing);

                  /// wait for text edit done / cancel
                  final result = await addText(
                    context,
                    child,
                  ) as DragableWidgetTextChild?;

                  /// change state to idle
                  /// so the menu UI will visible again
                  context
                      .read<EditPhotoCubit>()
                      .changeWidgetState(WidgetState.idle);

                  /// if user cancel add/edit text do nothing
                  if (result == null) return;

                  /// edit dragable widget in List<DragableWidget>
                  context.read<EditPhotoCubit>().editWidget(key, result);
                }
              },
              onLongPress: (uniqueKey) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return dialogDeleteTextConfirmation(context, uniqueKey);
                  },
                );
              },
            );

            /// add dragable widget to List<DragableWidget>
            context.read<EditPhotoCubit>().addWidget(widget);
          },
        ),
      ],
    );
  }
}
