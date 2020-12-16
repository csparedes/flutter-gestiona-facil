import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestiona_facil/src/blocs/provider.dart';
import 'package:gestiona_facil/src/models/producto_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProducto();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Productos'),
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) =>
                _crearItem(context, productosBloc, productos[i]),
          );
        } else {
          return Center(
            // child: CircularProgressIndicator(),
            child: CupertinoActivityIndicator(
              radius: 15,
            ),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) => productosBloc.borrarProducto(producto.proId),
      child: Card(
        child: Column(
          children: [
            (producto.proFoto == "" || producto.proFoto == null)
                ? Image(
                    image: AssetImage('assets/no-image.png'),
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(producto.proFoto),
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              leading: Icon(Icons.check),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${producto.proNombre}'),
                  Text('Categoría Id: ${producto.proIdCategoria}')
                ],
              ),
              subtitle: Text(producto.proId.toString()),
              onTap: () =>
                  Navigator.pushNamed(context, 'producto', arguments: producto)
                      .then((value) {
                setState(() {});
              }),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto').then((value) {
        setState(() {
          if (value) {
            print("Valor de value: $value");
          }
          print('Value en Null :v');
        });
      }),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
