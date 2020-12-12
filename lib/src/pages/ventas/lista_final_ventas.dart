import 'package:flutter/material.dart';

class ListaFinalVentas extends StatefulWidget {
  @override
  _ListaFinalVentasState createState() => _ListaFinalVentasState();
}

class _ListaFinalVentasState extends State<ListaFinalVentas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Compras'),
      ),
      body: _mostrarProductos(),
    );
  }

  _mostrarProductos() {
    return Center(
      child: Text('Aqui se mostrarán los productos'),
    );
  }
}
