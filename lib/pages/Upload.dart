import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;
  final _picker = ImagePicker();
  Container buidlSplashScreen() {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/upload.svg',
            // height: 200,
            width: 200,
          ),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () => selectImage(context),
                child: Text('Upload Image',
                    style: TextStyle(color: Colors.white, fontSize: 22.0)),
              ))
        ],
      ),
    );
  }

  Future getImageFromCamera() async {
    Navigator.of(context).pop();
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future getImageFromGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Text('create Post'),
            children: [
              SimpleDialogOption(
                child: Text(
                  'Photo with camera',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                onPressed: () => getImageFromCamera(),
              ),
              SimpleDialogOption(
                child: Text(
                  'Image from gallery',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                onPressed: () => getImageFromGallery(),
              ),
              SimpleDialogOption(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buidlSplashScreen() : Text('File selected');
  }
}
