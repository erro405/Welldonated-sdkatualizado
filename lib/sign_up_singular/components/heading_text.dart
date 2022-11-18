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
            const Center(
              child: Text('Criar conta', style: TextStyle(
                  wordSpacing: 4.0,
                  letterSpacing: 2.0,
                  fontFamily: 'Poppins',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
    );
  }
}
