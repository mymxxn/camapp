import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: CamApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class CamApp extends StatefulWidget {
  const CamApp({Key? key}) : super(key: key);

  @override
  State<CamApp> createState() => _CamAppState();
}

class _CamAppState extends State<CamApp> {
  File? _image;
  final imagePicker = ImagePicker();
  Future getImage(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    setState(() {
      _image = File(image!.path);
      GallerySaver.saveImage(_image!.path, albumName: "image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        title: const Text(
          "Camera",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: _image == null
            ? const Text("Take a pic",
                style: TextStyle(color: Colors.white, fontSize: 22))
            : Image.file(_image!),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: IconButton(
          onPressed: () => getImage(ImageSource.camera),
          icon: const Icon(Icons.camera_alt),
          tooltip: "increment",
        ),
      ),
    );
  }
}
