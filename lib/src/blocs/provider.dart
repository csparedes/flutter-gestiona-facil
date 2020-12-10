import 'package:flutter/material.dart';
import 'package:gestiona_facil/src/blocs/login_bloc.dart';

import 'package:gestiona_facil/src/blocs/productos_bloc.dart';
export 'package:gestiona_facil/src/blocs/productos_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;
  final loginBloc = LoginBloc();
  final _productosBloc = ProductosBloc();

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(
        key: key,
        child: child,
      );
    }

    return _instancia;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  // Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._productosBloc;
  }
}
