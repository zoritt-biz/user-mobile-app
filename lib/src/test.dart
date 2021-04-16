import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  Future compressAndGetFile(String file) async {
    int i = file.lastIndexOf('.');
    String filePath = file.substring(0, i);
    var result = await FlutterImageCompress.compressAndGetFile(
      file,
      filePath + '_compressed.jpg',
      quality: 60,
    );
    File(file).delete();
    setState(() {
      if (result != null) {
        _image = File(result.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return pickedFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => compressAndGetFile(await getImage()),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
