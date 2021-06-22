import 'package:flutter/material.dart';

class Square extends StatelessWidget{
  int size;

  @override
  Widget build(BuildContext context) {
    double sizeSqueare = (300/8) * 0.9;
    double margins = (300/16)*0.1;
    return
      Container(
      height: sizeSqueare,
      width: sizeSqueare,
      margin: EdgeInsets.only(
          top: margins,
          left: margins
      ),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
    );
  }
  Square(this.size);


}