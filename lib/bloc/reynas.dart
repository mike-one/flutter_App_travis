import 'dart:typed_data';
import '../repository/repository.dart';
import '../repository/persistence.dart';
import '../repository/factory.dart';

class Reynas {
  /**
   * Campo que definirá el tamaño del tablero
   */
  int _sizeBoard;

  /**
   * Lista en donde se almacenará la solución actual
   */
  late List<int> _board;

  late List<Uint8List> _memory = [];

  /**
   * número de soluciones
   */
  int _solutions = 0;

  /**
   * Constructor
   * @param sizeBoard: tamaño del tablero y número de reynas
   */
  Reynas(this._sizeBoard) {
    _board = new List.filled(_sizeBoard, 0);
  }

  /**
   * Función para iniciar la busqueda de distribucón de reynas
   */
  Future<int> iniciaRecorrido() async {

    //Se inicia en la columna 0
    _recorrido(0);

    //Terminando el recorrido se almacena el resultado en una base de datos
    Factory factory = Factory(_sizeBoard, _memory);
    Persistence storage = factory.getConexion("sqlite");

    await storage.save();
    await storage.getSolutions();

    //Se devuelve el número de soluciones
    return _solutions;
  }

  /**
   * Función para iniciar la busqueda de distribucón de reynas
   */
  int iniciaRecorridoTest() {
    //Medimos el tiempo de ejecución
    int timeFinal, time;
    int timeInit = new DateTime.now().millisecondsSinceEpoch;

    _recorrido(0); //Se inicia en la columna 0

    print(
        'Tamaño ocupado por el arreglo de soluciones: ${_memory.length * _sizeBoard / 1000000} MB');
    timeFinal = new DateTime.now().millisecondsSinceEpoch;
    time = timeFinal - timeInit;
    print('${time / 1000} s');
    return _solutions;
  }

  /**
   * función que realiza el recorrido por recursividad
   * @param columna: parámetro para indicar en qué columna
   * del arreglo se encuentra la iteración
   */
  void _recorrido(int column) {
    //Se valida si ya se recorrió el tablero
    if (column == _sizeBoard) {
      //Iprime o guarda el valor de la solución
      _saveSolution();
      return;
    } else
      for (int row = 0; row < _sizeBoard; row++) {
        if (_validateQueen(column, row)) {
          //Se guarda la nueva reyna
          _board[column] = row;
          //Continuamos con la siguiente columna
          _recorrido(column + 1);
        }
      }
  }

  /**
   * función que valida si la reyna que se quiere colocar no
   * ataca a las reynas anteriores
   * @param column: columna actual
   * @param row: renglón en donde se quiere colocar la nueva reyna
   * Retur false: si la nueva reyna ataca a una reyna anterior
   *       true: si la nueva reyna no ataca a ninguna reyna
   */
  bool _validateQueen(int column, int row) {
    //columnAux nos ayuda a recorrer la lista en los elementos anteriores
    for (int columnAux = 0; columnAux < column; columnAux++) {
      if (_board[columnAux] == row ||
          (column - columnAux) == (row - _board[columnAux]).abs())
        //Regresa un false si la reyna
        return false;
    }
    return true;
  }

  /**
   * Función que almacena el valor de la solución en algún lado
   */
  void _saveSolution() {
    _solutions++; //Contador de soluciones
    _memory.add(Uint8List.fromList(_board)); //Se guarda en memoria ram
    print(_board);
  }
}
