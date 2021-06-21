/**
 * Autor: Miguel Acosta Ventura
 *
 * Gran part del código se encuentra basado en el ejemplo de Flutter acerca de Persistencia de datos con SQLite:
 * https://esflutter.dev/docs/cookbook/persistence/sqlite
 * Quienes indican que:
 * Salvo que se indique lo contrario, este trabajo se encuentra bajo licencia de
 * Creative Commons Attribution 4.0 International License,
 * y los códigos de muestra tiene licencia bajo BSD License.
 *
 */

import 'dart:typed_data';

import 'package:flutter_app/model/solution.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/**
 * Clase que se encarga del manejo de base de datos
 */
class TaskDatabase {
  /**
   * Instancia de la Base de datos. Se debe implementar singleton
   */
  late Future<Database> _database;

  /**
   * String para el comando de crear tabla
   */
  String _createDataBaseCMD =
      "CREATE TABLE solutions(id INTEGER PRIMARY KEY, solution TEXT),";

  /**
   * String para el nombre de la tabla
   */
  String _board = "solutionsN";

  /**
   * Versión de la DB
   */
  int _version = 1;

  /**
   * Función para crear el comando de crear tabla según sea el tamaño del tablero
   */
  String initPath(int numSolutions) {
    //Se crea una tabla para la solución particular
    _board = "solutions$numSolutions";

    //Se agregan los primeros elementos
    String createDataBaseCMD = "CREATE TABLE $_board(id INTEGER PRIMARY KEY";

    //Agregamos las llaves
    for (int i = 0; i < numSolutions; i++) {
      createDataBaseCMD += ", solution$i INTEGER";
    }

    createDataBaseCMD += ");"; //Últimos ajustes de la query

    _createDataBaseCMD = createDataBaseCMD; //Se establece el comando

    return createDataBaseCMD; //Se retorna para hacer pruebas
  }

  /**
   * Función que crea la base de datos;
   */
  Future<void> createDataBase(String path) async {
    _database =
        openDatabase(join(await getDatabasesPath(), path), version: _version);
  }

  /**
   * Función que crea la tabla
   */

  Future<void> createTable(int sizeBoard) async {
    final Database database = await _database;
    initPath(sizeBoard);
    //Verificamos si hay algúna excepción a la hora de crear la tabla
    try {
      await database.execute(_createDataBaseCMD);
    } catch (e) {
      //No se está tomando ninguna acción por el momento
      //print(e);
    }
  }

  /**
   * Función para insertar una solución a la DB
   */
  Future<void> insertSolution(int sizeBoard, List<Uint8List> memory) async {
    //Indicamos en qué tabla vamos a insertar el valor
    String board = "solutions$sizeBoard";

    //Solicitamos la base de datos
    final Database database = await _database;

    //Obtenemos el valor a guardar de la matriz memory.
    // Se itera hasta guardar todos los valores.
    for (int i = 0; i < memory.length; i++) {
      Solution solution = Solution(i, memory[i], sizeBoard);
      //Insertamos la solución en la tabla correspondiente
      await database.insert(board, solution.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  /**
   * Obtenemos las soluciones de la DB y las almacenamos en memoria dinámica
   */
  Future<List<Uint8List>> solutionsDB(int sizeBoard) async {
    //Indicamos en qué tabla vamos a insertar el valor
    String board = "solutions$sizeBoard";

    //Solicitamos la base de datos
    final Database database = await _database;

    //Memoria a devolver
    List<Uint8List> memory = [];

    //Consultamos la DB y almacenamos el contenido en map
    final List<Map<String, dynamic>> mapMemory = await database.query(board);

    //Se parsean los valores
    for (int sizeMap = 0; sizeMap < mapMemory.length; sizeMap++) {
      List<int> solution = [];

      //Este for obtiene una solución y la parsea en 'solution'
      for (int sizeSolution = 0; sizeSolution < sizeBoard; sizeSolution++) {
        solution.add(mapMemory[sizeMap]['solution$sizeSolution']);
      }
      memory.add(Uint8List.fromList(solution)); //Se guarda en memoria ram
    }

    print("Se obtiene de la DB: ");
    for (int i = 0; i < memory.length; i++) {
      print("$i: ${memory[i]}");
    }

    return memory; //Retornamos el contenido
  }
}
