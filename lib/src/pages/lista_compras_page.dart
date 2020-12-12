import 'package:flutter/material.dart';
import 'package:gestiona_facil/src/blocs/productos_bloc.dart';
import 'package:gestiona_facil/src/models/producto_model.dart';
import 'package:gestiona_facil/src/pages/ventas/buscador_ventas.dart';
import 'package:gestiona_facil/src/pages/ventas/detector_page.dart';
import 'package:gestiona_facil/src/pages/ventas/lista_final_ventas.dart';

class ListaComprasPage extends StatefulWidget {
  const ListaComprasPage({Key key}) : super(key: key);

  @override
  _ListaComprasPageState createState() => _ListaComprasPageState();
}

class _ListaComprasPageState extends State<ListaComprasPage> {
  int _indexSeleccionado = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: _llamarPagina(_indexSeleccionado),
        bottomNavigationBar: _menuNavegacion(),
      ),
    );
  }

  BottomNavigationBar _menuNavegacion() {
    return BottomNavigationBar(
      currentIndex: _indexSeleccionado,
      onTap: (index) {
        setState(() {
          _indexSeleccionado = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page_outlined), label: 'Buscador'),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_outlined),
          label: 'Deteccion Objetos',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_sharp), label: 'Lista'),
      ],
    );
  }

  Widget _llamarPagina(int index) {
    switch (index) {
      case 0:
        return BuscadorVentas();
        break;
      case 1:
        return DetectorVentas();
        break;
      case 2:
        return ListaFinalVentas();
        break;
      default:
        return BuscadorVentas();
    }
  }
}
