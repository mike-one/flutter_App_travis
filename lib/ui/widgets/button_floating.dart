import 'package:flutter/material.dart';

class ButtonFloating extends StatefulWidget{
  /**
   * Función a ejecutar con tap en el botón
   */
  Function function;

  /**
   * Texto contenido en el botón
   */
  Icon icon;

  ButtonFloating({required this.icon,required this.function});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ButtonFloating(function, icon);
  }

}

class _ButtonFloating extends State<ButtonFloating>{
  /**
   * Función a ejecutar con tap en el botón
   */
  Function function;

  /**
   * Texto contenido en el botón
   */
  Icon icon;
  void onPressedButton(){
    function();
  }
  _ButtonFloating(this.function,this.icon);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          tooltip: "add",
          onPressed: onPressedButton,
          child: icon,
        )
      );

  }

}