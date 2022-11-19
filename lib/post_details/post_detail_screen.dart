import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';

class PostDetailScreen extends StatefulWidget {

  final String postId;
  const PostDetailScreen(this.postId);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  String? title = '';
  String? description = '';
  String? image = '';
  String? uid = '';
  File? imageXFile;


  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance.collection('posts')
        .doc(widget.postId)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists) {
        setState(() {
          title = snapshot.data()!['title'];
          description = snapshot.data()!['description'];
          image = snapshot.data()!['postImage'];
          uid = snapshot.data()!['id'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF283593),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Color(0xFF283593),
        title: Text(
          'Detalhes do anúncio',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontFamily: 'Segoi UI',
            fontSize: 23,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            _buildShowImage(),
            SizedBox(
              height: 20,
            ),
            _buildPostDetails(),
            SizedBox(
              height: 80,
            ),
            _buildOwnerDetails(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Lowerappbar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF9800),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildShowImage() => Container(
    width: 350,
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              child: Image.network(
                image!,
                height: 250,
                width: 650,
                fit: BoxFit.cover,
              ),
              ),
          ],
        ),
      ],
    ),
  );

  Widget _buildPostDetails() => Container(
    width: 350,
    child: Column(
      children: [
        Row(
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            Text(
              title!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            Text(
              description!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildOwnerDetails() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Column(
      children: <Widget>[
        Column(
          children: [
            Container(
              color: const Color(0xff4a5cc2),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sociedade Protetora \ndos Animais do Porto',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 50,),
                  Icon(Icons.account_circle_rounded,
                    color: Color(0xFF283593),
                    size: 80,
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xff4a5cc2),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 30,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Mais Informações',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]
    )
  );

  Widget buildcard5() => Container(
    child: Column(
      children: [
        Row(
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            _buildOwnerDetails(),
          ],
        ),
      ],
    ),
  );
}
