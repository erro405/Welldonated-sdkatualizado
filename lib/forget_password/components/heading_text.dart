import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
          children: [
            SizedBox(height: size.height * 0.00),
            Icon(
              Icons.lock_outline_rounded,
              color: Colors.white,
              size: 125.0,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Esqueceu-se da palavra-passe?',
              textAlign: TextAlign.center,
              style: TextStyle(
                wordSpacing: 4.0,
                letterSpacing: 1.0,
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                'Enviaremos as informações de recuperação da palavra-passe para o endereço de e-mail vinculado à sua conta.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 16.0,
                )),
            SizedBox(
              height: 15,
            ),
          ]),
    );
  }
}


