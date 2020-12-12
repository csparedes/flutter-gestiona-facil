import 'package:flutter/material.dart';

class BuscadorVentas extends StatefulWidget {
  @override
  _BuscadorVentasState createState() => _BuscadorVentasState();
}

class _BuscadorVentasState extends State<BuscadorVentas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Producto'),
      ),
      body: _mostrarProductos(),
    );
  }

  _mostrarProductos() {
    return Center(
      child: Text('Aqui se mostrarán los Productos a agregar'),
    );
  }

  // _mostrarBoton() {
  //   return FloatingActionButton(
  //     onPressed: () {},
  //     child: Icon(Icons.add),
  //     backgroundColor: Theme.of(context).primaryColor,
  //   );
  // }
}
