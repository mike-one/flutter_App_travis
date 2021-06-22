import 'package:flutter/material.dart';
import 'home_page.dart';
import 'results_page.dart';

class NavigationBar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavigationBar();
  }

}

class _NavigationBar extends State <NavigationBar>{
  //Indice para indicar la posición del tap en el navigationBar
  int indexTap = 0;

  final List<Widget> widgetsChildren =  [
    MyHomePage(title: 'Problema de las n Reynas'),
    ResultsPage(title: 'Flutter Demo Home Page'),
  ];

  void onTapTapped(int index){
    setState(() {
      indexTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue
        ),
        child: BottomNavigationBar(
          onTap: onTapTapped, //Se indica la función a ejecutar con Tap
          currentIndex: indexTap, //coloca el navigationBar en la posición indexTap
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              title: Text("Cálcular")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.slideshow),
                title: Text("Resultados")
            )

          ],
        ),
      ),
    );
  }

}