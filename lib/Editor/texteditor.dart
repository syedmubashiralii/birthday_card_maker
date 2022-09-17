import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Editor/EditorScreen.dart';
import 'package:birthday_app_new/Editor/JsonEditor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_painter/flutter_painter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TextEditor extends StatefulWidget {
  var img;
  TextEditor({Key? key, required this.img}) : super(key: key);

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  static const Color red = Color(0xFFFF0000);
  FocusNode textFocusNode = FocusNode();
  late PainterController controller;
  ui.Image? backgroundImage;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  static const List<String> imageLinks = [
    "http://134.209.195.127///img//y27.png",
    "http://134.209.195.127/json/y28.png",
    "http://134.209.195.127//json/y27.png",
    "http://134.209.195.127//json/y26.png",
    "http://134.209.195.127//json/y25.png",
    "http://134.209.195.127/json/y24.png",
    "http://134.209.195.127//json/y23.png",
    "http://134.209.195.127/json/y21.png",
    "http://134.209.195.127/json/y20.png",
    "http://134.209.195.127/json/y19.png",
    "http://134.209.195.127/json/y18.png",
    "http://134.209.195.127/json/y17.png",
    "http://134.209.195.127/json/y16.png",
    "http://134.209.195.127/json/y15.png",
    "http://134.209.195.127/json/y14.png",
    "http://134.209.195.127/json/y13.png",
    "http://134.209.195.127/json/y12.png",
    "http://134.209.195.127/json/y11.png",
    "http://134.209.195.127/json/y10.png",
    "http://134.209.195.127///img//y9.png",
    "http://134.209.195.127///img//y8.png",
    "http://134.209.195.127///img//y7.png",
    "http://134.209.195.127///img//y6.png",
    "http://134.209.195.127///img//y5.png",
    "http://134.209.195.127/json/t32.png",
    "http://134.209.195.127//json/sc26.png",
    "http://134.209.195.127///img//sc25.png",
    "http://134.209.195.127///img//sc24.png",
    "http://134.209.195.127///img//sc23.png",
    "http://134.209.195.127///img//sc22.png",
    "http://134.209.195.127/json/sc21.png",
    "http://134.209.195.127///img//sc20.png",
    "http://134.209.195.127///img//sc19.png",
    "http://134.209.195.127///img//sc18.png",
    "http://134.209.195.127/json/Layer125.png",
    "http://134.209.195.127///img//Layer124.png",
    "http://134.209.195.127/json/Layer123.png",
    "http://134.209.195.127///img//Layer122.png",
    "http://134.209.195.127/json/Layer77.png",
    "http://134.209.195.127///img//Layer76.png",
    "http://134.209.195.127/json/Layer75.png",
    "http://134.209.195.127///img//Layer74.png",
    "http://134.209.195.127/json/confetti.png",
    "http://134.209.195.127/json/Emojione_1F389.png",
  ];

  @override
  void initState() {
    super.initState();
    controller = PainterController(
        settings: PainterSettings(
            text: TextSettings(
              focusNode: textFocusNode,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: red, fontSize: 18),
            ),
            freeStyle: const FreeStyleSettings(
              color: red,
              strokeWidth: 5,
            ),
            shape: ShapeSettings(
              paint: shapePaint,
            ),
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )));
    // Listen to focus events of the text field
    textFocusNode.addListener(onFocus);
    // Initialize background
    initBackground();
  }

  /// Fetches image from an [ImageProvider] (in this example, [NetworkImage])
  /// to use it as a background
  void initBackground() async {
    // Extension getter (.image) to get [ui.Image] from [ImageProvider]
    final image = await MemoryImage(widget.img).image;

    setState(() {
      backgroundImage = image;
      controller.background = image.backgroundDrawable;
    });
  }

  /// Updates UI when the focus changes
  void onFocus() {
    setState(() {});
  }

  Widget buildDefault(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          // Listen to the controller and update the UI when it updates.
          child: ValueListenableBuilder<PainterControllerValue>(
              valueListenable: controller,
              child: const Text("Text Editor"),
              builder: (context, _, child) {
                return AppBar(
                  backgroundColor: colors.primarycolor,
                  title: child,
                  actions: [
                    // Delete the selected drawable
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.trash,
                      ),
                      onPressed: controller.selectedObjectDrawable == null
                          ? null
                          : removeSelectedDrawable,
                    ),

                    // Delete the selected drawable
                    IconButton(
                      icon: const Icon(
                        Icons.flip,
                      ),
                      onPressed: controller.selectedObjectDrawable != null &&
                              controller.selectedObjectDrawable is ImageDrawable
                          ? flipSelectedImageDrawable
                          : null,
                    ),
                    // Redo action
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.arrowClockwise,
                      ),
                      onPressed: controller.canRedo ? redo : null,
                    ),
                    // Undo action
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.arrowCounterClockwise,
                      ),
                      onPressed: controller.canUndo ? undo : null,
                    ),
                  ],
                );
              }),
        ),
        // Generate image
        floatingActionButton: FloatingActionButton(
          backgroundColor: colors.primarycolor,
          child: const Icon(
            Icons.done,
          ),
          onPressed: renderAndDisplayImage,
        ),
        body: Stack(
          children: [
            if (backgroundImage != null)
              // Enforces constraints
              Positioned.fill(
                child: Center(
                  child: AspectRatio(
                    aspectRatio:
                        backgroundImage!.width / backgroundImage!.height,
                    child: FlutterPainter(
                      controller: controller,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, _, __) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                          color: Colors.white54,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (controller.freeStyleMode !=
                                FreeStyleMode.none) ...[
                              const Divider(),
                              const Text("Free Style Settings"),
                              // Control free style stroke width
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Stroke Width")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 2,
                                        max: 25,
                                        value: controller.freeStyleStrokeWidth,
                                        onChanged: setFreeStyleStrokeWidth),
                                  ),
                                ],
                              ),
                              if (controller.freeStyleMode ==
                                  FreeStyleMode.draw)
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Color")),
                                    // Control free style color hue
                                    Expanded(
                                      flex: 3,
                                      child: Slider.adaptive(
                                          min: 0,
                                          max: 359.99,
                                          value: HSVColor.fromColor(
                                                  controller.freeStyleColor)
                                              .hue,
                                          activeColor:
                                              controller.freeStyleColor,
                                          onChanged: setFreeStyleColor),
                                    ),
                                  ],
                                ),
                            ],
                            if (textFocusNode.hasFocus) ...[
                              const Divider(),
                              const Text("Text settings"),
                              // Control text font size
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Font Size")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 8,
                                        max: 96,
                                        value:
                                            controller.textStyle.fontSize ?? 14,
                                        onChanged: setTextFontSize),
                                  ),
                                ],
                              ),

                              // Control text color hue
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("Color")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 0,
                                        max: 359.99,
                                        value: HSVColor.fromColor(
                                                controller.textStyle.color ??
                                                    red)
                                            .hue,
                                        activeColor: controller.textStyle.color,
                                        onChanged: setTextColor),
                                  ),
                                ],
                              ),
                            ],
                            if (controller.shapeFactory != null) ...[
                              const Divider(),
                              const Text("Shape Settings"),

                              // Control text color hue
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Stroke Width")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 2,
                                        max: 25,
                                        value: controller
                                                .shapePaint?.strokeWidth ??
                                            shapePaint.strokeWidth,
                                        onChanged: (value) =>
                                            setShapeFactoryPaint(
                                                (controller.shapePaint ??
                                                        shapePaint)
                                                    .copyWith(
                                              strokeWidth: value,
                                            ))),
                                  ),
                                ],
                              ),

                              // Control shape color hue
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("Color")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 0,
                                        max: 359.99,
                                        value: HSVColor.fromColor(
                                                (controller.shapePaint ??
                                                        shapePaint)
                                                    .color)
                                            .hue,
                                        activeColor: (controller.shapePaint ??
                                                shapePaint)
                                            .color,
                                        onChanged: (hue) =>
                                            setShapeFactoryPaint(
                                                (controller.shapePaint ??
                                                        shapePaint)
                                                    .copyWith(
                                              color: HSVColor.fromAHSV(
                                                      1, hue, 1, 1)
                                                  .toColor(),
                                            ))),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Fill shape")),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Switch(
                                          value: (controller.shapePaint ??
                                                      shapePaint)
                                                  .style ==
                                              PaintingStyle.fill,
                                          onChanged: (value) =>
                                              setShapeFactoryPaint(
                                                  (controller.shapePaint ??
                                                          shapePaint)
                                                      .copyWith(
                                                style: value
                                                    ? PaintingStyle.fill
                                                    : PaintingStyle.stroke,
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        //       bottomNavigationBar: ValueListenableBuilder(
        //         valueListenable: controller,
        //         builder: (context, _, __) => Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             // Free-style eraser
        //             IconButton(
        //               icon: Icon(
        //                 PhosphorIcons.eraser,
        //                 color: controller.freeStyleMode == FreeStyleMode.erase
        //                     ? Theme.of(context).accentColor
        //                     : null,
        //               ),
        //               onPressed: toggleFreeStyleErase,
        //             ),
        //             // Free-style drawing
        //             IconButton(
        //               icon: Icon(
        //                 PhosphorIcons.scribbleLoop,
        //                 color: controller.freeStyleMode == FreeStyleMode.draw
        //                     ? Theme.of(context).accentColor
        //                     : null,
        //               ),
        //               onPressed: toggleFreeStyleDraw,
        //             ),
        //             // Add text
        //             IconButton(
        //               icon: Icon(
        //                 PhosphorIcons.textT,
        //                 color: textFocusNode.hasFocus
        //                     ? Theme.of(context).accentColor
        //                     : null,
        //               ),
        //               onPressed: addText,
        //             ),
        //             // Add sticker image
        //             IconButton(
        //               icon: const Icon(
        //                 PhosphorIcons.sticker,
        //               ),
        //               onPressed: addSticker,
        //             ),
        //           ],
        //         ),
        //       ));
        // }

        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(36.0),
              ),
              color: colors.primarycolor),
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Free-style eraser
              IconButton(
                icon: Icon(PhosphorIcons.eraser, color: colors.secondarycolor),
                onPressed: toggleFreeStyleErase,
              ),
              // Free-style drawing
              IconButton(
                icon: Icon(PhosphorIcons.scribbleLoop,
                    color: colors.secondarycolor),
                onPressed: toggleFreeStyleDraw,
              ),
              // Add text
              IconButton(
                icon: Icon(PhosphorIcons.textT, color: colors.secondarycolor),
                onPressed: addText,
              ),
              // Add sticker image
              IconButton(
                icon: Icon(PhosphorIcons.sticker, color: colors.secondarycolor),
                onPressed: addSticker,
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return buildDefault(context);
  }

  void undo() {
    controller.undo();
  }

  void redo() {
    controller.redo();
  }

  void toggleFreeStyleDraw() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw
        ? FreeStyleMode.draw
        : FreeStyleMode.none;
  }

  void toggleFreeStyleErase() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.erase
        ? FreeStyleMode.erase
        : FreeStyleMode.none;
  }

  void addText() {
    if (controller.freeStyleMode != FreeStyleMode.none) {
      controller.freeStyleMode = FreeStyleMode.none;
    }
    controller.addText();
  }

  void addSticker() async {
    final imageLink = await showDialog<String>(
        context: context,
        builder: (context) => const SelectStickerImageDialog(
              imagesLinks: imageLinks,
            ));
    if (imageLink == null) return;
    controller.addImage(
        await NetworkImage(imageLink).image, const Size(100, 100));
  }

  void setFreeStyleStrokeWidth(double value) {
    controller.freeStyleStrokeWidth = value;
  }

  void setFreeStyleColor(double hue) {
    controller.freeStyleColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }

  void setTextFontSize(double size) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
    setState(() {
      controller.textSettings = controller.textSettings.copyWith(
          textStyle:
              controller.textSettings.textStyle.copyWith(fontSize: size));
    });
  }

  void setShapeFactoryPaint(Paint paint) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
    setState(() {
      controller.shapePaint = paint;
    });
  }

  void setTextColor(double hue) {
    controller.textStyle = controller.textStyle
        .copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor());
  }

  void selectShape(ShapeFactory? factory) {
    controller.shapeFactory = factory;
  }

  void renderAndDisplayImage() {
    if (backgroundImage == null) return;
    final backgroundImageSize = Size(
        backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());

    // Render the image
    // Returns a [ui.Image] object, convert to to byte data and then to Uint8List
    final imageFuture = controller
        .renderImage(backgroundImageSize)
        .then<Uint8List?>((ui.Image image) => image.pngBytes);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => EditorScreen(Img: imageFuture)));

    // From here, you can write the PNG image data a file or do whatever you want with it
    // For example:
    // ```dart
    // final file = File('${(await getTemporaryDirectory()).path}/img.png');
    // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // ```
    // I am going to display it using Image.memory

    // Show a dialog with the image
    showDialog(
        context: context,
        builder: (context) => RenderedImageDialog(imageFuture: imageFuture));
  }

  void removeSelectedDrawable() {
    final selectedDrawable = controller.selectedObjectDrawable;
    if (selectedDrawable != null) controller.removeDrawable(selectedDrawable);
  }

  void flipSelectedImageDrawable() {
    final imageDrawable = controller.selectedObjectDrawable;
    if (imageDrawable is! ImageDrawable) return;

    controller.replaceDrawable(
        imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
  }
}

class RenderedImageDialog extends StatelessWidget {
  final Future<Uint8List?> imageFuture;

  const RenderedImageDialog({Key? key, required this.imageFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Rendered Image"),
      content: FutureBuilder<Uint8List?>(
        future: imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 50,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          return InteractiveViewer(
              maxScale: 10,
              child: InkWell(
                  onTap: () {
                    Constants.isjson = false;
                    Constants.iseditingmode = true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                JsonEditor(img: snapshot.data)));
                  },
                  child: Image.memory(snapshot.data!)));
        },
      ),
      actions: [
        InkWell(
            onTap: () {},
            child: const Center(child: Text("Tap On Image to Save Changes!")))
      ],
    );
  }
}

class SelectStickerImageDialog extends StatelessWidget {
  final List<String> imagesLinks;

  const SelectStickerImageDialog({Key? key, this.imagesLinks = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select sticker"),
      content: imagesLinks.isEmpty
          ? const Text("No images")
          : FractionallySizedBox(
              heightFactor: 0.5,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (final imageLink in imagesLinks)
                      InkWell(
                        onTap: () => Navigator.pop(context, imageLink),
                        child: FractionallySizedBox(
                          widthFactor: 1 / 4,
                          child: CachedNetworkImage(
                            imageUrl: imageLink,
                            placeholder: (context, url) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
