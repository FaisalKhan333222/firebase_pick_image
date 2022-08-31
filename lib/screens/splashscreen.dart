import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_confirmpassword/showlistimages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../class/userid.dart';

class MySplashScreen extends StatefulWidget {
  String? userId;

  MySplashScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  ImagePicker imagePicker = ImagePicker();
  File? _image;
  String? downloadImage;
  String? downloadurl;

  @override
  Widget build(BuildContext context) {
    Modal modal = Modal();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .1,
              ),
              SizedBox(
                height: height * .6,
                width: width * .7,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red)),
                    child: SizedBox(
                      child: _image == null
                          ? Center(
                              child: Text('no image '),
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                    )),
              ),
              SizedBox(
                height: height * .3,
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text('selectImage'),
                      onPressed: () {
                        pickerImage();
                      },
                    ),
                    ElevatedButton(
                      child: Text('uploadImage'),
                      onPressed: () {
                        if (_image != null) {
                          uploadImage();
                        }
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              print('jkjk ${modal.uid}');
                              return MyShowListImages(
                                showList: modal.uid!,
                              );
                            },
                          ));
                        },
                        child: Text('ShowListImages'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickerImage() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        Text('no pick image');
      }
    });
  }

  Future uploadImage() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('${widget.userId}/images')
        .child('post${postId}');
    await reference.putFile(_image!);
    downloadurl = await reference.getDownloadURL();

    print(downloadurl);
    await firebaseFirestore
        .collection('user')
        .doc("${widget.userId}")
        .collection('images')
        .add({'downloadurl': downloadurl}).whenComplete(
      () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('upload image successfuly'),
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}

//   final postId = DateTime.now().millisecondsSinceEpoch.toString();
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   Reference ref = FirebaseStorage.instance
//       .ref()
//       .child("${widget.userId}/images")
//       .child('post_$postId');
//   await ref.putFile(_image!);
//   var downloadUrl = await ref.getDownloadURL();
//   await firebaseFirestore
//       .collection('users')
//       .doc(widget.userId)
//       .collection('images')
//       .add({'downloadUrl': downloadUrl}).whenComplete(
//           () => ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('upload image successfuly'),
//                   duration: Duration(seconds: 2),
//                 ),
//               ));
//
// }
