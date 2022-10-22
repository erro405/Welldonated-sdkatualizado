import 'package:flutter/material.dart';
import 'package:weeldonatedproject/costumwidgets/butoes.dart';

class ButaoSubmit extends butoes {


  ButaoSubmit({
    required String text,
    required VoidCallback onPressed,
}) : super(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    height: 44,
    color: Colors.deepOrange,
    borderRadius: 4,
    onPressed: onPressed,
  );
}