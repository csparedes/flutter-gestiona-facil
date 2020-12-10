import 'package:flutter/material.dart';
import 'package:gestiona_facil/src/pages/compras_page.dart';
import 'package:gestiona_facil/src/pages/home_page.dart';
import 'package:gestiona_facil/src/pages/ventas_page.dart';

class PreHomePage extends StatefulWidget {
  @override
  _PreHomePageState createState() => _PreHomePageState();
}

class _PreHomePageState extends State<PreHomePage> {
  int _indexSeleccionado = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _llamarPagina(_indexSeleccionado),
      bottomNavigationBar: _crearBarra(),
    );
  }

  Widget _llamarPagina(int index) {
    switch (index) {
      case 0:
        return HomePage();
        break;
      case 1:
        return ComprasPage();
        break;
      case 2:
        return VentasPage();
        break;
      default:
        return HomePage();
    }
  }

  Widget _crearBarra() {
    return BottomNavigationBar(
      currentIndex: _indexSeleccionado,
      onTap: (index) {
        setState(() {
          _indexSeleccionado = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Compras'),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store), label: 'Ventas'),
        // BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Admin'),
      ],
    );
  }
}
