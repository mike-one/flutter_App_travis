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