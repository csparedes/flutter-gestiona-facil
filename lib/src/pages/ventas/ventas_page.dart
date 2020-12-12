import 'package:flutter/material.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({Key key}) : super(key: key);

  @override
  _VentasPageState createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ventas Page"),
        ),
        body: _mostrarVentas(),
        floatingActionButton: _crearBotones(),
      ),
    );
  }

  Widget _mostrarVentas() {
    return Center(
      child: Text("Aqui se mostrarán las ventas que se han realizado"),
    );
  }

  Widget _crearBotones() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                print("Realizar Nueva venta");
                Navigator.pushNamed(context, 'listaCompras');
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
