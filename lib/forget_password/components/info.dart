import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app/choose_user_screen.dart';
import '../../app/emailpage.dart';

class Credentials extends StatefulWidget {
  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 10,
              ),
              filled: true,
              fillColor: Color(0xff3949AB),
              hintText: "E-mail",
              hintStyle: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _auth.sendPasswordResetEmail(email: _emailController.text);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.white,
                  content: Text("Foi enviado um e-mail para recuperar a sua palavra-passe.",
                  style: TextStyle(fontSize: 18.0),),
                ),
                );
              } on FirebaseAuthException catch(error) {
                Fluttertoast.showToast(msg: error.toString());
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) => EmailPage()));
            },
            child: const Text(
              'Recuperar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23.0,
                fontFamily: 'Poppins',
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffef6C00),
              fixedSize: const Size(200, 50),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ainda não tens conta?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              TextButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseUserScreen()));
                },
                child: const Text(
                  'Regista-te',
                  style: TextStyle(
                    fontFamily: 'Segoi UI',
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
