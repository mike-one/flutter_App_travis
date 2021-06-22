
import 'dart:typed_data';

/**
 * Clase Persistencia es usada como tipo interfaz para implementar
 * el patrón factory
 */
abstract class Persistence{
  int sizeBoard;
  late List<Uint8List> memory = [];

  Persistence(this.sizeBoard, this.memory);

  /**
   * Funciín para almacecnar en el storage
   */
  Future<void> save();

  /**
   * Funciín para llamar las soluciones del storage
   */
  Future<List<Uint8List>> getSolutions();

}