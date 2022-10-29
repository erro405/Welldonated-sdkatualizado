
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weeldonatedproject/app/backgound.dart';
import 'package:weeldonatedproject/log_in/login_screen.dart';
import 'package:weeldonatedproject/app/mainpage.dart';
import 'package:weeldonatedproject/app/choose_user_screen.dart';
import 'package:weeldonatedproject/sign_up/signup_screen.dart';

class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF283593),
        elevation: 0,
        actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'ww.png',
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 200,
                ),
                Container(
                  child: TextButton(
                    style: ButtonStyle(),
                    child: const Text(
                      'Ignorar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 6.5,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Color(0xFF283593)),
              ),
            ),
            buildcard1(),
            _buildcontent(),
            Container(
              color: Colors.white,
              width: 350,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Ainda não têm conta?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseUserScreen()));
                        },
                        child: Text(
                          'Registar',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('epic_interpainel_logo.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildcontent() {
    return Center(
      child: CustomPaint(
        painter: Backgound(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: LoginScreen(),
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildcard1() => Container(
        color: Color(0xFF283593),
        width: 350,
        child: Text(
          'WELL DONATED',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

  Widget buildcard2() => Container(
        color: Colors.white,
        width: 350,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                ),
                Text(
                  'Ainda não têm conta?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Registar',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Image.asset('epic_interpainel_logo.png'),
          ],
        ),
      );
}
