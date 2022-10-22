
import 'package:flutter/material.dart';

class Backgound extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
   final height = size.height;
   final width = size.width;
   Paint paint = Paint();
   Path mainBackgound = Path();

    mainBackgound.addRect(Rect.fromLTRB( 0, 0 , width, height));
    paint.color = Color(0xFF283593);

   canvas.drawPath(mainBackgound, paint);

    Path linearpath = Path();

    linearpath.moveTo( 0, height * 1);

    linearpath.lineTo(width * 0, height * 0.60); //1
    linearpath.lineTo(width * 0.5, height * 0.75);//1
    linearpath.lineTo(width * 1, height * 0.60);//3
    linearpath.lineTo(width * 1, height * 1);//4
    //linearpath.quadraticBezierTo(width * 0.65, height * 0.75, width * 1, height* 1);
    //linearpath.quadraticBezierTo(width * 0.58, height * 0.8, width * 1,height);
    linearpath.close();



    paint.color = Colors.white;
    canvas.drawPath(linearpath, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
      return oldDelegate !=this;

  }


}



