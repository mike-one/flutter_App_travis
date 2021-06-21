

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/repository/data_base.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async{
//  for (int boardSize = inicialCondition; boardSize <= majorTest; boardSize++)
  test("Función init de la base de datos para 8 soluciones", () {
    //Given
    TaskDatabase database = TaskDatabase();
    //When
    String query = "CREATE TABLE solutions8(id INTEGER PRIMARY KEY, solution0 INTEGER, solution1 INTEGER, solution2 INTEGER, solution3 INTEGER, solution4 INTEGER, solution5 INTEGER, solution6 INTEGER, solution7 INTEGER);";
    int numSolutions = 8;
    //Then
    expect(database.initPath(numSolutions), query);
  });
  test("Función init de la base de datos para 9 soluciones", () {
    //Given
    TaskDatabase database = TaskDatabase();
    //When
    String query = "CREATE TABLE solutions9(id INTEGER PRIMARY KEY, solution0 INTEGER, solution1 INTEGER, solution2 INTEGER, solution3 INTEGER, solution4 INTEGER, solution5 INTEGER, solution6 INTEGER, solution7 INTEGER, solution8 INTEGER);";
    int numSolutions = 9;
    //Then
    expect(database.initPath(numSolutions), query);
  });



}
