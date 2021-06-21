import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/bloc/reynas.dart';

Future main() async{
  //Given
  //Lista de los primeros 8 casos
  List<double> solutions = [92,352,724,2680,14200,73712,365596,2279184,14772512];
  int inicialCondition = 8; //El valor inicial de N deberá ser 8
  int majorTest = 10; //Fijamos un valor entre 8 y 15

  //When
  for (int boardSize = inicialCondition; boardSize <= majorTest; boardSize++)
    test("Primeros 8 casos de reynas", () async {
      Reynas reynas = Reynas(boardSize);


      //Then
      expect(reynas.iniciaRecorridoTest(), solutions[boardSize-inicialCondition]);
    });
}
