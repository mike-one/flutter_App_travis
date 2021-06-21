import 'dart:typed_data';

import 'package:flutter_app/repository/repository.dart';

import '../repository/persistence.dart';

/**
 * Se implementa el patrón factory por si se agregan más formas de almacenamiento en el futuro
 */
class Factory {
  int _sizeBoard;
  late List<Uint8List> _memory;


  Factory(this._sizeBoard, this._memory);

  Persistence getConexion(String motor ) {
    if (motor=="sqlite")
      return new Repository(_sizeBoard, _memory);

    //Por el momento mando por default la misma conexión
    return Repository(_sizeBoard, _memory);
  }
}
