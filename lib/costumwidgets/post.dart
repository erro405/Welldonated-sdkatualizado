import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class post extends StatefulWidget{

  final String amount;
  final String category;
  final String description;
  final String location;
  final int phoneNumber;
  final String postImage;
  final String title;


  post({
    required this.amount,
    required this.category,
    required this.description,
    required this.location,
    required this.phoneNumber,
    required this.postImage,
    required this.title,
});

  factory post.fromDocument(DocumentSnapshot doc){
    return post(
        amount: doc['amount'],
        category:  doc['category'],
        description:  doc['description'],
        location:  doc['location'],
        phoneNumber: doc[' phoneNumber'],
        postImage:  doc['postImage'],
        title:  doc['title'],
    );
  }



  @override
  _postState createState() => _postState(
   amount: this.amount,
   category: this.category,
   description: this.description,
   location: this.location,
   phoneNumber: this.phoneNumber,
   postImage: this.postImage,
   title: this.title,
  );
}

class _postState extends State<post>{

  final String amount;
  final String category;
  final String description;
  final String location;
  final int phoneNumber;
  final String postImage;
  final String title;


  _postState({
    required this.amount,
    required this.category,
    required this.description,
    required this.location,
    required this.phoneNumber,
    required this.postImage,
    required this.title,
  });

  buildPostImage(){
    return GestureDetector(
      onDoubleTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.network(postImage),
        ],
      ),
    );
  }
 // buildPostDesc(){
   // return FutureBuilder(
     // builder: (context, snapshot){
       // if(!snapshot.hasData) {
         // return circularProgress();
        //}

     // },
    //);
  //}

  @override
  Widget build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      buildPostImage(),
    //  buildPostDesc(),
    ],
  );
  }

}

