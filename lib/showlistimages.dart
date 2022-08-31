import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyShowListImages extends StatefulWidget {
  String showList;
  MyShowListImages({Key? key, required this.showList}) : super(key: key);

  @override
  State<MyShowListImages> createState() => _MyShowListImagesState();
}

class _MyShowListImagesState extends State<MyShowListImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.showList)
            .collection('images')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('no data');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                print(snapshot.data!.docs.length);
                String url = snapshot.data!.docs[index]['download'];
                return Image.network(
                  url,
                  height: 300,
                  fit: BoxFit.cover,
                );
              },
            );
          }
        },
      ),
    );
  }
}
