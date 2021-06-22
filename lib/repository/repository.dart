import 'dart:typed_data';

import 'package:flutter_app/repository/data_base.dart';
import 'package:flutter_app/repository/persistence.dart';

/**
 * En esta clase se distribuyen las peticiones a la base de datos
 */
class Repository extends Persistence{

  /**
   * Instancia de la base de datos
   */
  TaskDatabase database = TaskDatabase();

  /**
   * Nombre de la base de datos
   */
  String nameDataBase = "base_prueba30.db";

  Repository(int sizeBoard, List<Uint8List> memory) : super(sizeBoard, memory);

  /**
   * Función que ejecuta las funciones para hacer el almacenamiento
   * Aquí lo ideal hubise sido implementar singleton para no hacer varias instancias
   * cada que se ejecuta el código
   */
  Future<void> save() async {
    await database.createDataBase(nameDataBase);
    database.initPath(sizeBoard);
    await database.createTable(sizeBoard);
    await database.insertSolution(sizeBoard, memory);
  }


  /**
   * Función que devuelve las soluciones almacenadas en la base de datos
   */
  Future<List<Uint8List>> getSolutions() async {
    await database.createDataBase(nameDataBase);
    database.initPath(sizeBoard);
    await database.createTable(sizeBoard);
    memory =  await database.solutionsDB(sizeBoard);
    return memory;
  }


}
