import 'package:flutter/material.dart';

import 'package:gestiona_facil/src/blocs/provider.dart';
import 'package:gestiona_facil/src/pages/home_page.dart';
import 'package:gestiona_facil/src/pages/lista_compras_page.dart';
import 'package:gestiona_facil/src/pages/login_page.dart';
import 'package:gestiona_facil/src/pages/pre_home_page.dart';
import 'package:gestiona_facil/src/pages/producto_page.dart';
import 'package:gestiona_facil/src/pages/registro_page.dart';
import 'package:gestiona_facil/src/pages/ventas_page.dart';
import 'package:gestiona_facil/src/preferencias_usuario/prefrencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'login': (BuildContext context) => LoginPage(),
          'producto': (BuildContext context) => ProductoPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'ventas': (BuildContext context) => VentasPage(),
          'prehome': (BuildContext context) => PreHomePage(),
          'listaCompras': (BuildContext context) => ListaComprasPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(25, 128, 131, 1),
        ),
        locale: Locale('es', 'ES'),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
