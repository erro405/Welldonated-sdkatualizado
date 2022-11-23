import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';
import 'package:weeldonatedproject/posts_feed/feed_screen.dart';

class PostDetailScreen extends StatefulWidget {

  final String postId;
  const PostDetailScreen(this.postId);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _amountDonation = new TextEditingController();
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
            try {
              String? userName = '';
              String? userEmail = '';
              String? userPhoneNum = '';
              await FirebaseFirestore.instance.collection('users')
                  .doc(_auth.currentUser!.uid)
                  .get()
                  .then((snapshot) async
              {
                if(snapshot.exists) {
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
                            'Teste',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
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
