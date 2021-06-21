import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/button_floating.dart';
import '../../bloc/reynas.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /**
   * Textos desplegados
   */
  //Títulos
  String _giveMeNumQueensTitle = "Dame el número de Reynas";
  String _calculateQueensTitle = "Calcular Reynas";

  //Mensajes
  String _minimumQueensMessage = "El número mínimo de reynas es 8";

  /**
   * Número de reynas
   */
  int _queens = 8;

  /**
   * Bandera que indica si hay que regresar el progress
   */
  bool _progress = false;

  /**
   * Widget a regresar
   */
  Widget? _screen;

  /**
   * Objeto para hacer el calculo
   */
  Reynas? _calculateQueens;

  /**
   * Número de soluciones
   */
  int _solutions = 0;

  /**
   * Constructor
   */
  _MyHomePageState() {
    //screen = _homeScreen();
  }

  /**
   * Función para incrementar el contador de reynas
   */
  void _incrementCounter() {
    setState(() {
      _queens++;
    });
  }

  /**
   * Función para decrementar el contador de reynas
   */
  void _decreaseCounter() {
    setState(() {
      if (_queens > 8)
        _queens--;
      else
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(_minimumQueensMessage)));
    });
  }

  void _calculatePositions() async {
    _calculateQueens = Reynas(_queens);
    _progress = true;

    setState(() {
      _progress = true;
    });

    _solutions = await _calculateQueens!.iniciaRecorrido();

    setState(() {
      _progress = false;
    });

    /*
      if ((_solutions = _calculateQueens!.iniciaRecorrido()) > 0.0)
        _screen = _MyHomePageState() as Widget?;
      */
  }

  /**
   * Widget a devolver
   */
  @override
  Widget build(BuildContext context) {
    return _screen ?? _homeScreen();
  }

  Widget _progressCenter() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _homeScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_giveMeNumQueensTitle),
            _textSizeQueens(),
            _rowsButtons(),
            Text(_calculateQueensTitle),
            _buttonCalculate(),
            Text("Número de soluciones:"),
            if (_progress)
              CircularProgressIndicator()
            else
              _textNumSolutions(),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
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

  /**
   * Botón para calcular las soluciones
   */

  Widget _buttonCalculate() {
    return Container(
        margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
        child: ButtonFloating(
            icon: Icon(Icons.calculate_outlined),
            function: _calculatePositions));
  }

  /**
   * Renglones contenedores de los botones
   */
  Widget _rowsButtons() {
    return Container(
      margin: EdgeInsets.only(top: 30.0, bottom: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonFloating(icon: Icon(Icons.remove), function: _decreaseCounter),
          ButtonFloating(icon: Icon(Icons.add), function: _incrementCounter)
        ],
      ),
    );
  }
}
