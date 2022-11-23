import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';
import 'package:weeldonatedproject/app/pagina18.dart';
import 'active_announcements.dart';
import '../costumwidgets/LowerAppBar.dart';
import 'emailpage.dart';

class ProfileScreenCollective extends StatefulWidget {
  @override
  State<ProfileScreenCollective> createState() => _ProfileScreenCollectiveState();
}

class _ProfileScreenCollectiveState extends State<ProfileScreenCollective> {
  String? name = '';
  String? email = '';
  String? image = '';
  String? phoneNo = '';
  String? fullAddress = '';
  String? category = '';
  File? imageXFile;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
          email = snapshot.data()!['email'];
          image = snapshot.data()!['userImage'];
          phoneNo = snapshot.data()!['phoneNumber'];
          fullAddress = snapshot.data()!['fullAddress'];
          category = snapshot.data()!['category'];
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
        leading: IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(
            Icons.edit,
            size: 35.0,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pagina18()));
          },
        ),
        backgroundColor: Color(0xff1a237e),
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.logout_rounded,
                size: 35.0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmailPage()));
              },
            );
          }),
        ],
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
                SizedBox(
                  height: 15,
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
                SizedBox(
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
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
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
                SizedBox(
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
                        email!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
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
                SizedBox(
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
                          wordSpacing: 2.0,
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
                SizedBox(
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
                        fullAddress!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
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
                SizedBox(
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
                        category!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
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
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveAnnouncements()));
                  },
                  child: Text(
                    'Gerir anúncios',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffef6C00),
                    fixedSize: Size(180, 50),
                  ),
                ),
                SizedBox(
                  height: 60,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

