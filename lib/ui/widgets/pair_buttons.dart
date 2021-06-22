import 'package:flutter/material.dart';
import '../widgets/button_floating.dart';

class PairButtons extends StatefulWidget {
/**
 * Función a ejecutar con tap en el botón left
 */
Function functionLeft;

/**
 * Función a ejecutar con tap en el botón right
 */
Function functionRight;

/**
 * Texto contenido en el botón
 */
Icon iconLeft;

/**
 * Texto contenido en el botón
 */
Icon iconRight;

/**
 * Se define el constructor con los parámetros nombrados pues facilita al programador a colocar los parámetros
 */

PairButtons( {required this.functionLeft, required this.functionRight, required this.iconLeft, required this.iconRight});


  @override
  State<StatefulWidget> createState() {
    return _PairButtons(functionLeft, functionRight, iconLeft, iconRight); //Se llama a la clase privada

  }

}


class _PairButtons extends State <PairButtons> {

  /**
   * Función a ejecutar con tap en el botón left
   */
  Function functionLeft;

  /**
   * Función a ejecutar con tap en el botón right
   */
  Function functionRight;

  /**
   * Texto contenido en el botón
   */
  Icon iconLeft;

  /**
   * Texto contenido en el botón
   */
  Icon iconRight;

  /**
   * Constructor de la clase privada
   */
  _PairButtons(
      this.functionLeft, this.functionRight, this.iconLeft, this.iconRight);

  @override
  Widget build(BuildContext context) {
    return _rowsButtons(); //Se regresa el arreglo de botones
  }

  //Se colocan las funciones

  void onPressedButtonLeft(){
    functionLeft();
  }

  void onPressButtonRigth(){
    functionRight();
  }

  /**
   * Renglones contenedores de los botones
   */
  Widget _rowsButtons() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonFloating(icon: iconLeft, function: functionLeft ),
          ButtonFloating(icon: iconRight, function:  functionRight )
        ],
      ),
    );
  }


}