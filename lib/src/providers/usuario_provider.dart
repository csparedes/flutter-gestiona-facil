import 'dart:convert';
// import 'dart:html';

import 'package:gestiona_facil/src/preferencias_usuario/prefrencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _fireBaseToken = 'AIzaSyDS-I4yxp0thCUE-6aWZhKFSvjnLy7fPfw';
  final _prefs = new PreferenciasUsuario();
  static String tokenNode = '';

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }

  login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_fireBaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    // print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];

      final backendData = {'usuEmail': email, 'usuPassword': password};
      final Map<String, String> head = {
        "Accept": "*/*",
        "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      };
      final url = 'http://10.0.2.2:3000/api/usuario/login';

      final result = await http.post(url, headers: head, body: backendData);
      Map<String, dynamic> aux = json.decode(result.body);

      tokenNode = aux['token'];
      // print('Token de Node: ' + tokenNode);

      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }

  // String getToken() => tokenNode;
}
