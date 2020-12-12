import 'package:flutter/material.dart';

class DetectorVentas extends StatefulWidget {
  @override
  _DetectorVentasState createState() => _DetectorVentasState();
}

class _DetectorVentasState extends State<DetectorVentas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detección de Objetos'),
      ),
      body: _mostrarCamara(),
    );
  }

  _mostrarCamara() {
    return Center(
      child: Text('Aqui se mostrará la cámara'),
    );
  }
}
