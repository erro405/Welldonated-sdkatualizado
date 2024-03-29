import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../costumwidgets/LowerAppBar.dart';
import '../posts_feed/feed_screen.dart';
import 'profile_details_publisher_collective.dart';
import 'profile_details_publisher_singular.dart';

class PostDetailScreen extends StatefulWidget {

  final String postId;
  final String publishUid;
  const PostDetailScreen(this.postId, this.publishUid);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _amountDonation = new TextEditingController();
  bool _amountValid = false;

  String? title = '';
  String? description = '';
  String? image = '';
  String? uid = '';
  String? location = '';
  File? imageXFile;

  String? publishUsername = '';
  String? publishRole = '';
  String? userImage = '';

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
          location = snapshot.data()!['location'];
        });
      }
    });
  }

  Future _getDataFromPublishUser() async {
    await FirebaseFirestore.instance.collection('users')
        .doc(widget.publishUid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists) {
        setState(() {
          publishUsername = snapshot.data()!['name'];
          publishRole = snapshot.data()!['role'];
          userImage = snapshot.data()!['userImage'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabase();
    _getDataFromPublishUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser!.isAnonymous) {
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
          child: Container(
            child: ListView(
              children: [
                _buildShowImage(),
                const SizedBox(
                  height: 20,
                ),
                _buildPostDetails(),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
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
    } else {
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
          child: Container(
            child: ListView(
              children: [
                _buildShowImage(),
                const SizedBox(
                  height: 20,
                ),
                _buildPostDetails(),
                const SizedBox(
                  height: 60,
                ),
                _buildDonateField(),
                SizedBox(
                  height: 30,
                ),
                _buildOwnerDetails(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
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

  Widget _buildDonateField() => Padding(
    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
    child: Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child:TextFormField(
              controller: _amountDonation,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                filled: true,
                fillColor: Color(0xff1a237e),
                hintText: "Quantidade a doar",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                errorText: _amountValid ? 'Quantidade não pode ficar em branco' : null,
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Poppins',
              ),
            ),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () async {
            if (_amountDonation.text.isEmpty) {
              setState(() {
                _amountDonation.text.isEmpty ? _amountValid = true : _amountValid = false;
              });
            } else {
              try {
                String? userName = '';
                String? userEmail = '';
                String? userPhoneNum = '';
                await FirebaseFirestore.instance.collection('users')
                    .doc(_auth.currentUser!.uid)
                    .get()
                    .then((snapshot) async
                {
                  if (snapshot.exists) {
                    userName = snapshot.data()!['name'];
                    userEmail = snapshot.data()!['email'];
                    userPhoneNum = snapshot.data()!['phoneNumber'];
                  }
                });

                final User? user = _auth.currentUser;
                final _uid = user!.uid;

                FirebaseFirestore.instance
                    .collection('posts').doc(widget.postId)
                    .collection('donateIntention').doc(_uid).set({
                  'uid': _uid,
                  'name': userName,
                  'email': userEmail,
                  'phoneNumber': userPhoneNum,
                  'postId': widget.postId,
                  'amount': _amountDonation.text,
                });
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              } catch (error) {
                Fluttertoast.showToast(msg: error.toString());
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen()));
            }
          },
          child: Text(
            'DOAR',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
          ),
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
                  fontWeight: FontWeight.bold
              ),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                color: const Color(0xff4a5cc2),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            publishUsername! + "\n" + location!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              //_showImageDialog
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              minRadius: 45.0,
                              child: CircleAvatar(
                                radius: 42.0,
                                backgroundImage: imageXFile == null
                                    ?
                                NetworkImage(
                                    userImage!
                                )
                                    :
                                Image.file
                                  (imageXFile!).image,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                color: const Color(0xff4a5cc2),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          if (publishRole!.contains("singular")) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetailPublisherSingular(widget.publishUid)));
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetailPublisherCollective(widget.publishUid)));
                          }
                        },
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
