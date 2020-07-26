import 'package:flutter/material.dart';
import 'package:qrapp/src/pages/mapas_page.dart';

import 'direcciones_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _llamarPagina(indexActual),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _llamarPagina(int paginaActual) {
    // pagina actual es una variable entera que recibe el valor de la pagina, en caso de que no haya valor muestra MapasPage()
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    // Este widget es la barra de navegacion inferior
    return BottomNavigationBar(
      // el widget se llama asi
      currentIndex: indexActual, // este es el valor index actual
      onTap: (index) {
        // al darle Tap
        setState(() {
          // se Seteara el estado de
          indexActual = index; // index sera igual al indexActual
        });
      },
      items: [
        // Aqui estan los items de la barra de navegacion, aqui son 2 * son necesarios minimo 2 para funcionar el BottomNavigationBarItem
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("Mapas"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text("Direcciones"),
        ),
      ],
    );
  }
}
