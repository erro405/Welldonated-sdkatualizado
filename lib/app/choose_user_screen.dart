import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../sign_up_collective/signup_screen_collective.dart';
import '../sign_up_singular/signup_screen_singular.dart';
import 'emailpage.dart';

class ChooseUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3949ab),
        leadingWidth: 25,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            alignment: Alignment.centerRight,
            icon: const Icon(
              Icons.navigate_before_outlined,
              size: 40.0,
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EmailPage()));
            },
          );
        }),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xff3949ab),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 28.0,
                ),
                Text(
                  'Escolha o seu perfil...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    wordSpacing: 4.0,
                    letterSpacing: 2.0,
                    fontFamily: 'Poppins',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ElevatedButton(
                  child: Image.asset('individual.png'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreenSingular()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(120, 120),
                    shape: const CircleBorder(),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  'Sou uma pessoa singular',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 42.0,
                ),
                ElevatedButton(
                  child: Image.asset('comum.png'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreenCollective()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(120, 120),
                    shape: const CircleBorder(),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  'Sou uma pessoa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'coletiva / instituição',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _paginaAnterior() {
    //
  }
}
