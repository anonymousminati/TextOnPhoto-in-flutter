import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_editor/models/text_info.dart';
import 'package:photo_editor/screens/edit_image_screen.dart';
import 'package:photo_editor/utils/utils.dart';

import 'package:photo_editor/widgets/default_button.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditImageViewModel extends State<ImageEditorScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  List<TextInfo> texts = [];
  int currentIndex = 0;
  ScreenshotController screenshotController = ScreenshotController();
  final ScrollController scrollController = ScrollController();
  setCurrentIndex(BuildContext context, int index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Text  selected for styling',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Offset myPointerDragAnchorStrategy(
      Draggable<Object> draggable, BuildContext context, Offset position) {
    return Offset(10, 0);
  }

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image);
      }).catchError((onError) {
        print(onError);
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Saved',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  saveImage(Uint8List? bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'Screenshot-$time';
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(
      bytes!,
      name: name,
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize++;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize--;
    });
  }

  leftAlignText() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  centerAlignText() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  rightAlignText() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldText() {
    setState(() {
      texts[currentIndex].fontWeight == FontWeight.bold
          ? texts[currentIndex].fontWeight = FontWeight.normal
          : texts[currentIndex].fontWeight = FontWeight.bold;
    });
  }

  italicText() {
    setState(() {
      texts[currentIndex].fontStyle == FontStyle.italic
          ? texts[currentIndex].fontStyle = FontStyle.normal
          : texts[currentIndex].fontStyle = FontStyle.italic;
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
            text: textEditingController.text,
            left: 0,
            top: 0,
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            textAlign: TextAlign.left),
      );
      textEditingController.clear();
      Navigator.of(context).pop();
    });
  }

  deleteText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Add new text'),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            filled: true,
            hintText: 'your text here',
          ),
        ),
        actions: [
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.white,
            textColor: Colors.black,
            child: Text('Back'),
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            color: Colors.red,
            textColor: Colors.red,
            child: Text('Add Text'),
          )
        ],
      ),
    );
  }
}
