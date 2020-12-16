import 'package:flutter/material.dart';

import 'package:gestiona_facil/src/blocs/kardex_existencia_bloc.dart';
import 'package:gestiona_facil/src/blocs/provider.dart';
import 'package:gestiona_facil/src/models/kardex_existencia_model.dart';
import 'package:gestiona_facil/src/utils/search_delegate.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

class BuscadorVentas extends StatefulWidget {
  @override
  _BuscadorVentasState createState() => _BuscadorVentasState();
}

class _BuscadorVentasState extends State<BuscadorVentas> {
  @override
  Widget build(BuildContext context) {
    final kardexExistenciasBloc = Provider.kardexExistenciaBloc(context);
    kardexExistenciasBloc.cargarKardexExistencia();

    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Producto'),
        actions: _botonesAppBar(),
      ),
      body: _crearListado(kardexExistenciasBloc),
    );
  }

  _crearListado(KardexExistenciaBloc kardexExistenciaBloc) {
    return StreamBuilder(
      stream: kardexExistenciaBloc.kardexExistenciaStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<KardexExistenciaModel>> snapshot) {
        if (snapshot.hasData) {
          print("Entro al snapshot.data");
          final kardex = snapshot.data;
          print("length" + kardex.length.toString());
          print(kardex.toString());
          return ListView.builder(
            itemCount: kardex.length,
            itemBuilder: (context, i) =>
                _crearItem(context, kardexExistenciaBloc, kardex[i]),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("Buscando las existencias de productos"),
              ],
            ),
          );
        }
      },
    );
  }

  _crearItem(BuildContext context, KardexExistenciaBloc kardexBloc,
      KardexExistenciaModel kardex) {
    return ListTile(
      leading: Icon(
        Icons.star_border,
        size: 30,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kardex.keProNombre,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Fecha Caducidad: ${kardex.keFechaCaducidad}'),
          Text('Cantidad: ${kardex.keCantidad}'),
          Text('Valor Unitario: ${kardex.keValorUnitario}'),
          Text('Valor Total: ${kardex.keValorTotal}')
        ],
      ),
      subtitle: Text('ID: ${kardex.keId}'),
      onTap: () {
        //TODO: implementar el agregado a la lista de venta
      },
    );
  }

  _botonesAppBar() {
    return [
      IconButton(
        icon: Icon(Icons.find_in_page_outlined),
        onPressed: _buscadorExistencias,
      ),
    ];
  }

  _buscadorExistencias() {
    showSearch(
      context: context,
      delegate: DataSearch(),
    );
  }
}
