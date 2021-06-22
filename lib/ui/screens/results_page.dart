import 'package:flutter/material.dart';
import '../widgets/chessboard.dart';
import '../widgets/button_floating.dart';
import '../widgets/pair_buttons.dart';
import 'package:flutter_app/bloc/access_memory.dart';

class ResultsPage extends StatefulWidget{

  /**
   * Título del AppBar
   */
  final String title;

  //Constructor
  ResultsPage({required this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResultsPage();

  }

}

class _ResultsPage extends State<ResultsPage> {
  /**
   * Número de reynas
   */
  int _queens = 8;

  /**
   * Número de soluciones
   */
  int _solutions = 0;

  //Mensajes
  String _minimumQueensMessage = "El número mínimo de reynas es 8";
  String _maximumQueensMessage = "El número máximo de reynas es 15";

  /**
   * Textos desplegados
   */
  //Títulos
  String _giveMeNumQueensTitle = "Número de Reynas";
  String _calculateQueensTitle = "Solución";

  //Se utiliza para definir el tamaño del tablero en pantalla
  double size = 25.0;
  late List<List<int>> memory = [];
  late List<int> _board = [0];

  //Objeto que nos permite tener acceso a la base de datos
  late AccessMemory accessMemory;
  //  Uint8 position = 0;

  //Constructor
  _ResultsPage();

  //Consultamos la base de datos
  Future<void> functionMemory() async {
    accessMemory = await AccessMemory(_queens);
    memory = await accessMemory.getSoltions();

    setState(() {
      _board = memory[_solutions];
    });

  }

  /**
   * Función que disminuye el número de reynas
   */
  Future<void> functionLeft() async {
    setState(() {
      if (_queens > 8)
        _queens--;
      else
        Scaffold.of(context)  //Sólo se permite disminuír hasta 8.
            .showSnackBar(SnackBar(content: Text(_minimumQueensMessage)));
    });

    await functionMemory(); //Consultamos la BD pues debemos cambiar de tabla de soluciones

  }

  /**
   * Función que nos permite aumentar el número de reynas
   * El número máximo son 16, pues con 16 Reynas las soluciones son demasiadas
   * y para su calculo tarda mucho la aplicación
   */
  Future<void> functionRight() async {
    setState(() {
      if(_queens < 16)
        _queens++;
      else
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(_maximumQueensMessage)));
    });

    await functionMemory();

  }

  /**
   * Muestra la solución anterior
   */
  void previusSolution(){
    setState(() {
      if(_solutions > 0)
        _solutions--;
        _board = memory[_solutions]; // Se carga en un arreglo la solución
    });
  }

  /**
   * Muestra la siguiente solución
   */
  void nextSolution(){
    setState(() {
      _solutions++;
      _board = memory[_solutions];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 180.0, right: 10, left: 0),
        child: Column(
          children: [
            new ChessBoardCustomPaint.withDefaultPainter(size,_queens, _board),
            Row(
              children: [
                Column(children: [
                  Text(_giveMeNumQueensTitle),
                  _textSizeQueens(),
                  new PairButtons(functionLeft: functionLeft, functionRight: functionRight, iconLeft: Icon(Icons.remove), iconRight: Icon(Icons.add)),
                ],),
                Column( children: [
                  new PairButtons(functionLeft: previusSolution, functionRight: nextSolution, iconLeft: Icon(Icons.west_sharp), iconRight: Icon(Icons.arrow_forward_rounded)),
                  Text(_calculateQueensTitle),
                  _textNumSolutions(),

                ],)
              ],
            ),
             new ButtonFloating(icon: Icon(Icons.save), function: functionMemory)
          ],
        )
      ),

    );

  }

  /**
   * Texto que muestra el número de reynas a ingresar al cálculo
   */
  Widget _textSizeQueens() {
    return Text(
      '$_queens',
      style: Theme.of(context).textTheme.headline4,
    );
  }

  /**
   * Texto que muestra el número de soluciones calculadas
   */
  Widget _textNumSolutions() {
    return Text(
      '$_solutions',
      style: Theme.of(context).textTheme.headline4,
    );
  }




}