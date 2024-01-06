import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:photo_editor/widgets/edit_image_viewmodel.dart';
import 'package:photo_editor/widgets/image_text.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditorScreen extends StatefulWidget {
  const ImageEditorScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 30.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Screenshot(
                controller: screenshotController,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: _selectedImage,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < texts.length; i++)
                      Positioned(
                          left: texts[i].left,
                          top: texts[i].top,
                          child: GestureDetector(
                            onLongPress: () {
                              deleteText(context);
                            },
                            onTap: () => setCurrentIndex(context, i),
                            child: Draggable(
                              dragAnchorStrategy: myPointerDragAnchorStrategy,
                              feedback: ImageText(textInfo: texts[i]),
                              child: ImageText(textInfo: texts[i]),
                              onDragEnd: (drag) {
                                final renderBox =
                                    context.findRenderObject() as RenderBox;
                                Offset off =
                                    renderBox.localToGlobal(Offset.zero);
                                setState(() {
                                  texts[i].left =
                                      max(0, off.dx + drag.offset.dx);
                                  texts[i].top =
                                      max(0, off.dy + drag.offset.dy) - 96;
                                });
                              },
                            ),
                          )),
                    creatorText.text.isNotEmpty
                        ? Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              creatorText.text,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            _toolBar,
          ],
        ),
      ),
      floatingActionButton: _addNewTextFAB,
    );
  }

  PreferredSize get _toolBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
            height: 50,
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                children: [
                  IconButton(
                    onPressed: () => saveToGallery(context),
                    icon: Icon(
                      Icons.save,
                      color: Colors.black,
                    ),
                    tooltip: 'Save Image',
                  ),
                  IconButton(
                    onPressed: () => increaseFontSize(),
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    tooltip: 'Increase Font Size',
                  ),
                  IconButton(
                    onPressed: () => decreaseFontSize(),
                    icon: Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                    tooltip: 'Decrease Font Size',
                  ),
                  IconButton(
                    onPressed: () => leftAlignText(),
                    icon: Icon(
                      Icons.format_align_left,
                      color: Colors.black,
                    ),
                    tooltip: 'Align Left',
                  ),
                  IconButton(
                    onPressed: () => centerAlignText(),
                    icon: Icon(
                      Icons.format_align_center,
                      color: Colors.black,
                    ),
                    tooltip: 'Align Center',
                  ),
                  IconButton(
                    onPressed: () => rightAlignText(),
                    icon: Icon(
                      Icons.format_align_right,
                      color: Colors.black,
                    ),
                    tooltip: 'Align right',
                  ),
                  IconButton(
                    onPressed: () => boldText(),
                    icon: Icon(
                      Icons.format_bold,
                      color: Colors.black,
                    ),
                    tooltip: 'Bold',
                  ),
                  IconButton(
                    onPressed: () => italicText(),
                    icon: Icon(
                      Icons.format_italic,
                      color: Colors.black,
                    ),
                    tooltip: 'Italic',
                  ),
                  IconButton(
                    onPressed: () => addLinesToText(),
                    icon: Icon(
                      Icons.space_bar,
                      color: Colors.black,
                    ),
                    tooltip: 'Add new Line',
                  ),
                  Tooltip(
                    message: 'White',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.white),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Tooltip(
                    message: 'Red',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.red),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Tooltip(
                    message: 'Black',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.black),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Tooltip(
                    message: 'Blue',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.blue),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Tooltip(
                    message: 'Yellow',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.yellow),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Tooltip(
                    message: 'Green',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.green),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Tooltip(
                    message: 'Orange',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.orange),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Tooltip(
                    message: 'Pink',
                    child: GestureDetector(
                      onTap: () => changeTextColor(Colors.pink),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.0, color: Colors.black),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget get _selectedImage {
    return Center(
      child: Image.file(
        File(widget.imagePath),
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget get _addNewTextFAB {
    return FloatingActionButton(
      onPressed: () => addNewDialog(context),
      backgroundColor: Colors.black,
      tooltip: 'Add new text',
      child: const Icon(
        Icons.add,
        color: Colors.lightBlueAccent,
      ),
    );
  }
}
