
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:weeldonatedproject/sign_up_collective/signup_screen_one_collective.dart';

import '../posts_feed/feed_screen.dart';

class SignUpScreenTwoCollective extends StatefulWidget {
  RegistarInst createState() => RegistarInst();
}

class RegistarInst extends State<SignUpScreenTwoCollective> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailTextController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3949ab),
          elevation: 0.0,
          leadingWidth: 25,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.navigate_before_outlined,
                size: 40.0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreenOneCollective()));
              },
            );
          }),
          title: Text(
            'Voltar',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Segoi UI',
              fontSize: 20,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                color: Color(0xff3949ab),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Para Concluir',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      TextFormField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 6,
                            ),
                            filled: true,
                            fillColor: Color(0xff1a237e),
                            hintText: "E-mail",
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
                      SizedBox(
                        height: 28.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 6,
                          ),
                          filled: true,
                          fillColor: Color(0xff1a237e),
                          hintText: "Palavra-passe",
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
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 1.3,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      Text(
                        'Ao clicar em Registar, está a concordar com os Termos do Serviço e com a Política de Privacidade da Well Donated',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 1.0,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(
                        height: 38.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FeedScreen()));
                        },
                        child: Text(
                          'Registar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffef6C00),
                          fixedSize: Size(200, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (Platform.isIOS) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3949ab),
          elevation: 0.0,
          leadingWidth: 25,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.navigate_before_outlined,
                size: 40.0,
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreenOneCollective()));
              },
            );
          }),
          title: Text(
            'Voltar',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Segoi UI',
              fontSize: 20,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                color: Color(0xff3949ab),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Para Concluir',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.3,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Color(0xff3949ab),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        child: CupertinoButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white60,
                              )
                            ],
                          ),
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                //actions: [buildPicker()],
                                cancelButton: CupertinoActionSheetAction(
                                  child: Text('Confirmar'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      Card(
                        child: TextFormField(
                          maxLines: 5,
                          cursorColor: Colors.white,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 2,
                            ),
                            filled: true,
                            fillColor: Color(0xff1a237e),
                            hintText: "  Descrição (Opcional)",
                            hintStyle: TextStyle(
                              fontSize: 21.0,
                              fontFamily: 'Poppins',
                              color: Colors.white70,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 1.3,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 1.3,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
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
                        height: 28.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: 6,
                          ),
                          filled: true,
                          fillColor: Color(0xff1a237e),
                          hintText: "  Palavra-passe",
                          hintStyle: TextStyle(
                            fontSize: 21.0,
                            fontFamily: 'Poppins',
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 1.3,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 1.3,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: 6,
                          ),
                          filled: true,
                          fillColor: Color(0xff1a237e),
                          hintText: "  Confirmar Palavra-passe",
                          hintStyle: TextStyle(
                            fontSize: 21.0,
                            fontFamily: 'Poppins',
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 1.3,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 1.3,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        'Ao clicar em Registar, está a concordar com os Termos do Serviço e com a Política de Privacidade da Well Donated',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 1.0,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(
                        height: 38.0,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FeedScreen()));
                        },
                        child: Text(
                          'Registar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffef6C00),
                          fixedSize: Size(200, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    throw new Container();
  }
}
