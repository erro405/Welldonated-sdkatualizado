import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/active_posts/active_announcements.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';
import 'package:weeldonatedproject/profile/edit_profile_singular.dart';
import '../costumwidgets/LowerAppBar.dart';
import '../app/emailpage.dart';

class ProfileDetailPublisher extends StatefulWidget {

  final String publishUid;
  const ProfileDetailPublisher(this.publishUid);

  @override
  State<ProfileDetailPublisher> createState() => _ProfileDetailPublisherState();
}

class _ProfileDetailPublisherState extends State<ProfileDetailPublisher> {

  String? name = '';
  String? email = '';
  String? image = '';
  String? phoneNo = '';
  File? imageXFile;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance.collection('users')
        .doc(widget.publishUid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
          email = snapshot.data()!['email'];
          image = snapshot.data()!['userImage'];
          phoneNo = snapshot.data()!['phoneNumber'];
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
      appBar: AppBar(
        backgroundColor: Color(0xff1a237e),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xff1a237e),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    //_showImageDialog
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    minRadius: 80.0,
                    child: CircleAvatar(
                      radius: 75.0,
                      backgroundImage: imageXFile == null
                          ?
                      NetworkImage(
                          image!
                      )
                          :
                      Image.file
                        (imageXFile!).image,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 4.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        email!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 4.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        phoneNo!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 4.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Lowerappbar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF9800),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}