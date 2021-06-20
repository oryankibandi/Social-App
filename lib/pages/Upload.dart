import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unishare/models/User.dart';
import 'package:unishare/pages/Home.dart';

class Upload extends StatefulWidget {
  final User currentUser;

  Upload({this.currentUser});

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

  clearImage() {
    setState(() {
      file = null;
    });
  }

  buildUploadScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: clearImage, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Upload Image'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Post',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ))
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black),
                //alignment: Alignment.center,
                width: size.width * 0.9,
                height: size.height * 0.3,
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                tileColor: Colors.grey[100],
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.photoUrl),
                ),
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter a caption. . .',
                    border: InputBorder.none,
                  ),
                ),
                contentPadding: EdgeInsets.all(2.0),
              ),
              Divider(),
              ListTile(
                tileColor: Colors.grey[100],
                leading: Icon(
                  Icons.location_pin,
                  color: Colors.orange,
                  size: 35.0,
                ),
                title: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Where was this picture taken...'),
                ),
                contentPadding: EdgeInsets.all(2.0),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: size.width * 0.5,
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.location_pin),
                        label: Text('Use current location'))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buidlSplashScreen() : buildUploadScreen();
  }
}
