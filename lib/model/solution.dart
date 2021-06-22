import 'package:flutter/material.dart';

class Solution{
  /**
   * Tamaño de la solución
   */
  final int sizeSolution;

  /**
   * id de la solución
   */
  final int id;

  /**
   * Lista que contiene la solución
   */
  final List<int> solution;

  /**
   * Constructor
   */

  Solution(this.id, this.solution, this.sizeSolution);

  /**
   * Map que se regresa
   *
   * Se acomoda de tal forma que se puedan almacenar en una base de datos
   * y con tablas distintas entre soluciones. Así evitamos el desperdicio de memoria
   * Aunque terminamos con DB no relacionales
   */

  Map<String,dynamic> toMap(){

    Map <String,dynamic> map = {'id':id};

    for(int i =0; i < solution.length;i++ ){
      map["solution${i}"] = "${solution[i]}";
    }

//    print("Valor del map :$map");
    return map;
  }
}