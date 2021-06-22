import 'dart:typed_data';
import '../repository/repository.dart';
import '../repository/persistence.dart';
import '../repository/factory.dart';

/**
 * Clase que nos permite leer la base de datos
 */
class AccessMemory{
  int _sizeBoard;  //tamaño del teclado
  late List<Uint8List> _memory=[]; //memoria

//Clase para tener accesos a la Base de datos
 AccessMemory( this._sizeBoard);

 //Función que regresa las soluciones
  Future<List<List<int>>>getSoltions() async {

//    Hacemos una fábrica para llamar a la DB
    Factory factory = Factory(_sizeBoard, _memory);
//Solicitamos la DB de sqlite
    Persistence storage = await factory.getConexion("sqlite");
//Pedimos las soluciones almacenadas
    List<List<int>> memory = await storage.getSolutions();

    //regresamos un arreblo con las soluciones
    return memory;

  }




}