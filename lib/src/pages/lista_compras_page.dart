import 'package:flutter/material.dart';
import 'package:gestiona_facil/src/blocs/productos_bloc.dart';
import 'package:gestiona_facil/src/models/producto_model.dart';

class ListaComprasPage extends StatefulWidget {
  const ListaComprasPage({Key key}) : super(key: key);

  @override
  _ListaComprasPageState createState() => _ListaComprasPageState();
}

class _ListaComprasPageState extends State<ListaComprasPage> {
  @override
  Widget build(BuildContext context) {
    List<ProductoModel> listaProductos =
        ModalRoute.of(context).settings.arguments;
    ProductosBloc productosBloc = new ProductosBloc();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Compras"),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Lista de Compras'),
              ListView.builder(
                itemBuilder: (context, item) {
                  _crearItem(context, productosBloc, listaProductos[item]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) =>
          productosBloc.borrarProducto(producto.prodId.toString()),
      child: Card(
        child: Column(
          children: [
            (producto.prodFotoUrl == "" || producto.prodFotoUrl == null)
                ? Image(
                    image: AssetImage('assets/no-image.png'),
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(producto.prodFotoUrl),
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
                  Text(
                      '${producto.prodNombreProducto} = ${producto.prodPrecioVenta}'),
                  Text('El producto caduca el: ${producto.prodFechaCaducidad}')
                ],
              ),
              subtitle: Text(producto.prodId.toString()),
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
}
