import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/AnuncioPage.dart';
import 'package:weeldonatedproject/app/AnuncioPage2.dart';
import 'package:weeldonatedproject/app/Editpage.dart';
import 'package:weeldonatedproject/app/IntencaoDoacao.dart';
import 'package:weeldonatedproject/app/IntencaoDoacao2.dart';
import 'package:weeldonatedproject/app/emailpage.dart';
import 'package:weeldonatedproject/app/mainpage.dart';
import 'package:weeldonatedproject/app/choose_user_screen.dart';
import 'package:weeldonatedproject/app/pagina4.dart';
import 'package:weeldonatedproject/app/pagina5.dart';
import 'package:weeldonatedproject/app/pagina10.dart';
import 'package:weeldonatedproject/profile_screen/profile_screen.dart';
import 'package:weeldonatedproject/app/pagina17.dart';
import 'package:weeldonatedproject/app/pagina13.dart';
import 'package:weeldonatedproject/app/pagina18.dart';
import 'package:weeldonatedproject/sign_up/signup_screen.dart';


void main(){
   runApp(Myapp());

}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomePage(),
        //debugShowCheckedModeBanner: false,
      //title: 'Welldonated',
     // home: EmailPage(),
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
