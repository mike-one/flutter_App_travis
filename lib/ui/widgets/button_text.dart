import 'package:flutter/material.dart';

class ButtonText extends StatefulWidget{
  /**
   * Función a ejecutar con tap en el botón
   */
  Function function;

  /**
   * Texto contenido en el botón
   */
String text;

  ButtonText({required this.text,required this.function});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ButtonText(function, text);
  }

}

class _ButtonText extends State<ButtonText>{
  /**
   * Función a ejecutar con tap en el botón
   */
  Function function;

  /**
   * Texto contenido en el botón
   */
String text;

  void onPressedButton(){
    function();
  }
  _ButtonText(this.function,this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
          margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0
          ),
          height: 50.0,
          width: 180.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),

          ),
          child:
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white
              ),
            ),
          ),
      );

  }

}