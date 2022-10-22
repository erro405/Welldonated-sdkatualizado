import 'package:flutter/material.dart';

class butoes extends StatelessWidget {
  butoes({
    required this.child,
    required this.color,
    this.borderRadius: 2,
    this.height: 30,
    required this.onPressed,

  }) : assert(borderRadius !=null);

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child:ElevatedButton(
        child: child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

