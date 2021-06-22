import 'package:flutter/material.dart';
/***
 * Este código lo tomé prestado de un progarmador con alias 'laurent bernabé' subido a la página de internet:
 *https://gitter.im/flutter/flutter/archives/2018/03/29?at=5abd0d1b27c509a774b87e6e
 *  @loloof64 mar. 29 2018 09:58 UTC. Sirve para dibujar el tablero en pantalla.
 *
 *  Lo modifiqué para desplegar las Reynas en las posiciones con color Rojo
 */

/**
 * Se trata de una clase que extiende de CustomPainter
 * y facilita el dibujar la matriz
 */
class ChessBoardCustomPainter extends CustomPainter {
  final double _cellsSize;
  int _sizeBoard;
  List<int> _board;
  ChessBoardCustomPainter(this._cellsSize, this._sizeBoard, this._board);

  @override
  void paint(Canvas canvas, Size size) {
    _paintCells(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


  /**
   * Está es la función dibuja el tablero
   */
  void _paintCells(Canvas canvas, Size size) {
    print("Solución actual: ${_board}"); //Se imprime la solución en linea de comandos

    for (int rank = 0; rank < _sizeBoard; rank++){
      for (int file = 0; file < _sizeBoard; file++){
        Color? currentCellColor = (file+rank) %2 > 0 ? Colors.amber[200] : Colors.brown;
        if(_board[rank] == file)    //Se agregó esta modificación para pintar el cuadro de otro color
        currentCellColor = Colors.deepOrange as Color;
        final Paint paint = new Paint()
          ..color = currentCellColor!;
        final upperLeft = new Offset(
            _cellsSize * (0.5 + file -2), //También moví la matriz a la izquierda porque estaba muy pegada a la derecha
            _cellsSize * (7.5 - rank)
        );
        final lowerRight = upperLeft.translate(_cellsSize, _cellsSize);
        final Rect paintZone = new Rect.fromPoints(
            upperLeft, lowerRight  //Se pinta la zona del cuadro
        );

        canvas.drawRect(paintZone, paint);
      }
    }
  }


}

/**
 * Esta clase es la que noos ayuda a llamar la matriz
 *
 * Esoecificamente el método withDefaultPainter.
 */
class ChessBoardCustomPaint extends CustomPaint {
  final double _cellsSize;
  final ChessBoardCustomPainter _painter;
  List<int> _board =[];

  ChessBoardCustomPaint(this._cellsSize, this._painter) : super(
      size: new Size.square(10*_cellsSize)
  );



  ChessBoardCustomPaint.withDefaultPainter(double cellsSize, int sizeBoard, List<int> board): this(
      cellsSize, new ChessBoardCustomPainter(cellsSize,sizeBoard, board));


  @override
  CustomPainter get painter => _painter;
}