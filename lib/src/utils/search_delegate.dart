import 'package:flutter/material.dart';

import 'package:gestiona_facil/src/providers/kardex_existencias_provider.dart';
import 'package:gestiona_facil/src/providers/productos_provider.dart';

import 'package:gestiona_facil/src/models/producto_model.dart';

class DataSearch extends SearchDelegate {
  final kardexExistencia = new KardexExistenciasProvider();
  final productosProvider = new ProductosProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: productosProvider.buscarProducto(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          return _mostrarProductos(snapshot.data);
        } else {
          return Center(
            child: Text('No data'),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: productosProvider.buscarProducto(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          return _mostrarProductos(snapshot.data);
        } else {
          return Center(
            child: Text('No data'),
          );
        }
      },
    );
  }

  Widget _mostrarProductos(List<ProductoModel> productos) {
    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (_, i) {
        final producto = productos[i];

        return ListTile(
          leading: FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(producto.proFoto),
            fit: BoxFit.cover,
            width: 50,
          ),
          title: Text(producto.proNombre),
          subtitle: Text(producto.proIdCategoria),
          onTap: () {
            close(_, null);
            print('Producto Id: ' + producto.proId);
            //agregar el producto a la lista
          },
        );
      },
    );
  }
}
