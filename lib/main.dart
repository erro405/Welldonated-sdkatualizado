import 'package:WellDonated/forget_password/forget_password.dart';
import 'package:WellDonated/log_in/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/emailpage.dart';

void main(){
   runApp(Myapp());

}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage>{
  Future<FirebaseApp>_initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              return EmailPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}
