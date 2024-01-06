import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor/screens/edit_image_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: IconButton(
            icon: const Icon(Icons.upload_file, size: 50),
            onPressed: () async {
              XFile? file = await picker.pickImage(source: ImageSource.gallery);
              if (file != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageEditorScreen(
                      imagePath: file.path,
                    )
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
//
// //create a HomeScreen class that extends StatelessWidget and returns a Scaffold widget. make this wodget for selecting an image from the gallery and showing it on the screen. make two dropdown menu , one for text color and one for text size. make a text field for entering text. make a button for saving the image. make a button for selecting an image from the gallery. make text to be move over image while editing
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   //create a variable for storing the image path
//   final String imagePath = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         //create a body for the scaffold
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               //create a container for showing the image
//               Container(
//                 height: 300,
//                 width: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: imagePath == ''
//                     ? const Icon(
//                         Icons.upload_file,
//                         size: 50,
//                       )
//                     : Image.file(
//                         File(imagePath),
//                         fit: BoxFit.cover,
//                       ),
//               ),
//               //create a dropdown menu for selecting the text color
//               DropdownButton(
//                 items: const [
//                   DropdownMenuItem(
//                     child: Text('Red'),
//                     value: Colors.red,
//                   ),
//                   DropdownMenuItem(
//                     child: Text('Green'),
//                     value: Colors.green,
//                   ),
//                   DropdownMenuItem(
//                     child: Text('Blue'),
//                     value: Colors.blue,
//                   ),
//                 ],
//                 onChanged: (value) {},
//               ),
//               //create a dropdown menu for selecting the text size
//               DropdownButton(
//                 items: const [
//                   DropdownMenuItem(
//                     child: Text('Small'),
//                     value: 20.0,
//                   ),
//                   DropdownMenuItem(
//                     child: Text('Medium'),
//                     value: 30.0,
//                   ),
//                   DropdownMenuItem(
//                     child: Text('Large'),
//                     value: 40.0,
//                   ),
//                 ],
//                 onChanged: (value) {},
//               ),
//               //create a text field for entering text
//               TextField(
//                 decoration: const InputDecoration(
//                   hintText: 'Enter text',
//                 ),
//               ),
//               //create a button for saving the image
//               ElevatedButton(
//                 onPressed: () {
//                   //add the functionality to save the image
//
//
//
//
//                 },
//                 child: const Text('Save'),
//               ),
//               //create a button for selecting an image from the gallery
//               ElevatedButton(
//                 onPressed: () {},
//                 child: const Text('Select Image'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
