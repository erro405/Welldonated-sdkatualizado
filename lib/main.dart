import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/post_details/post_detail_screen.dart';
import 'package:weeldonatedproject/app/Editpage.dart';
import 'package:weeldonatedproject/app/IntencaoDoacao.dart';
import 'package:weeldonatedproject/app/IntencaoDoacao2.dart';
import 'package:weeldonatedproject/app/emailpage.dart';
import 'package:weeldonatedproject/posts_feed/feed_screen.dart';
import 'package:weeldonatedproject/app/choose_user_screen.dart';
import 'package:weeldonatedproject/sign_up_collective/signup_screen_collective.dart';
import 'package:weeldonatedproject/sign_up_collective/signup_screen_two_collective.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';
import 'package:weeldonatedproject/log_in/login_screen.dart';
import 'package:weeldonatedproject/profile_screen/profile_screen.dart';
import 'package:weeldonatedproject/app/pagina17.dart';
import 'package:weeldonatedproject/app/pagina13.dart';
import 'package:weeldonatedproject/app/pagina18.dart';

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
