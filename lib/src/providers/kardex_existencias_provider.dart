import 'dart:convert';
// import 'dart:io';
import 'package:gestiona_facil/src/models/kardex_existencia_model.dart';
import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';

import 'package:gestiona_facil/src/providers/usuario_provider.dart';

class KardexExistenciasProvider {
  final String _url = 'http://10.0.2.2:3000/api/kardexExistencia';
  final String token = UsuarioProvider.tokenNode;

  Map<String, String> _cabecera = {
    "Accept": "*/*",
    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
  };

  Future<List<KardexExistenciaModel>> cargarExistencias() async {
    final url = '$_url';

    _cabecera["token"] = UsuarioProvider.tokenNode;

    final resp = await http.get(url, headers: _cabecera);
    final Map<String, dynamic> decodedData = jsonDecode(resp.body);
    final List<KardexExistenciaModel> listaExistencias =
        new List<KardexExistenciaModel>();

    if (decodedData == null) {
      return [];
    }

    decodedData.forEach((key, value) {
      if (key == "existencias") {
        final List aux = value;

        aux.forEach((element) {
          listaExistencias.add(KardexExistenciaModel.fromJson(element));
        });
      }
    });

    return listaExistencias;
  }
}
