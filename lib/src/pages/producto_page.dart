import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:gestiona_facil/src/blocs/productos_bloc.dart';
import 'package:gestiona_facil/src/blocs/provider.dart';
import 'package:gestiona_facil/src/models/producto_model.dart';
// import 'package:gestiona_facil/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;
  String _textoBoton = 'Guardar';
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    productosBloc = Provider.productosBloc(context);
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
            (producto.proNombre == null) ? 'Sin Texto' : producto.proNombre),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _mostrarCategoria(),
                // _crearPrecioVenta(),
                // _crearPrecioCompra(),
                // _crearFechaCaducidad(context),
                // _crearDisponible(),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.proNombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => producto.proNombre = value,
      // validator: (value) {
      //   if (value.length < 3) {
      //     return 'Ingrese el nombre del producto';
      //   } else {
      //     return null;
      //   }
      // },
    );
  }

  Widget _mostrarCategoria() {
    return TextFormField(
      initialValue: producto.proIdCategoria,
      // textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Categoría',
      ),
      onSaved: (value) => producto.proIdCategoria = value,
      // validator: (value) {
      //   if (value.length < 3) {
      //     return 'Ingrese el código del producto';
      //   } else {
      //     return null;
      //   }
      // },
    );
  }

  // Widget _crearFechaCaducidad(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       Text(producto.prodFechaCaducidad.isNotEmpty
  //           ? producto.prodFechaCaducidad
  //           : 'Fecha de Caducidad'),
  //       RaisedButton.icon(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20.0),
  //         ),
  //         color: Theme.of(context).primaryColor,
  //         textColor: Colors.white,
  //         icon: Icon(Icons.calendar_today),
  //         label: Text('Escoja una Fecha'),
  //         onPressed: () {
  //           Future<DateTime> fecha = showDatePicker(
  //             context: context,
  //             initialDate: DateTime.now(),
  //             firstDate: DateTime(2019),
  //             lastDate: DateTime(2026),
  //             confirmText: 'Aceptar',
  //             cancelText: 'Cancelar',
  //             helpText: 'Calendario',
  //             builder: (BuildContext context, Widget child) {
  //               return Theme(
  //                 data: ThemeData.light().copyWith(
  //                   colorScheme: ColorScheme.light(
  //                     primary: Colors.white,
  //                     onPrimary: Theme.of(context).primaryColor,
  //                     surface: Colors.white,
  //                     onSurface: Colors.white,
  //                   ),
  //                   dialogBackgroundColor: Color.fromRGBO(25, 128, 131, 0.7),
  //                   // dialogBackgroundColor: Colors.white,
  //                 ),
  //                 child: child,
  //               );
  //             },
  //           );

  //           setState(() {
  //             fecha.then((value) =>
  //                 producto.prodFechaCaducidad = utils.transformarFecha(value));
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _crearPrecioVenta() {
  //   return TextFormField(
  //     initialValue: producto.prodPrecioVenta.toString(),
  //     keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(
  //       labelText: 'Precio de Venta',
  //     ),
  //     onSaved: (value) => producto.prodPrecioVenta = value,
  //     validator: (value) {
  //       if (utils.isNumeric(value)) {
  //         return null;
  //       } else {
  //         return 'Solo números';
  //       }
  //     },
  //   );
  // }

  // Widget _crearPrecioCompra() {
  //   return TextFormField(
  //     initialValue: producto.prodPrecioCompra.toString(),
  //     keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(
  //       labelText: 'Precio de Compra',
  //     ),
  //     onSaved: (value) => producto.prodPrecioCompra = value,
  //     validator: (value) {
  //       if (utils.isNumeric(value)) {
  //         return null;
  //       } else {
  //         return 'Solo números';
  //       }
  //     },
  //   );
  // }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text(_textoBoton),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _textoBoton = 'Espere por fa :v';
      _guardando = true;
    });

    if (foto != null) {
      producto.proFoto = await productosBloc.subirFoto(foto);
      // print("Secure link foto: " + producto.proFoto);
    }
    // print("Producto id " + producto.proId.toString());
    if (producto.proId == "" || producto.proId == null) {
      producto.proId = '0';
      print("En producto page: " + producto.mostrarProducto());
      productosBloc.agregarProducto(producto);
    } else {
      productosBloc.editarProducto(producto);
    }

    setState(() {
      _textoBoton = 'Guardar';
      _guardando = false;
    });
    mostrarSnackBar(context, 'Registro Guardado...');
    Navigator.pop(context);
  }

  // Widget _crearDisponible() {
  //   return SwitchListTile(
  //     title: Text('Disponible'),
  //     value: producto.disponible,
  //     activeColor: Theme.of(context).primaryColor,
  //     onChanged: (value) => setState(
  //       () {
  //         producto.disponible = value;
  //       },
  //     ),
  //   );
  // }

  void mostrarSnackBar(BuildContext context, String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  // _mostrarFoto() {
  //   if (producto.prodFotoUrl != null || producto.prodFotoUrl != '') {
  //     return FadeInImage(
  //         placeholder: AssetImage('assets/jar-loading.gif'),
  //         image: NetworkImage(producto.prodFotoUrl));
  //   } else {
  //     return Image(
  //       // placeholder: AssetImage('assets/jar-loading.gif'),
  //       image: AssetImage(foto?.path ?? 'assets/no-image.png'),
  //       // image: AssetImage('assets/no-image.png'),
  //       height: 200.0,
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }
  _mostrarFoto() {
    if (producto.proFoto != null) {
      return Container(
        child: FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(producto.proFoto)),
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    // foto = await ImagePicker.pickImage(source: origen);
    final aux = await picker.getImage(source: origen);
    if (aux != null) {
      foto = File(aux.path);
    }
    setState(() {
      if (foto != null) {
        producto.proFoto = null;
      } else {
        print("Ninguna imagen seleccionada en _procesarImagen()");
      }
    });
  }
}
