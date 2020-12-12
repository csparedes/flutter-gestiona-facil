import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:gestiona_facil/src/models/producto_model.dart';
import 'package:gestiona_facil/src/providers/usuario_provider.dart';

class ProductosProvider {
  // final String _url =
  //     'https://appmovil.gestionafacil.ibx.lat/viveres_stalin/public/productos';

  final String _url = 'http://10.0.2.2:3000/api/productos';
  // final _prefs = new PreferenciasUsuario();
  final String token = UsuarioProvider.tokenNode;

  Map<String, String> _cabecera = {
    "Accept": "*/*",
    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
  };

  Future<bool> crearProducto(ProductoModel producto) async {
    print("instancia de crear Producto: " + producto.mostrarProducto());

    // _cabecera["token"] = UsuarioProvider.tokenNode;
    final url = '$_url';
    final respuesta = await http.post(
      url,
      body: producto.toJson(),
      headers: _cabecera,
    );
    final aux = json.decode(respuesta.body);
    print('Respuesta de Crear Producto\n' + aux['message']);
    return true;
  }

  Future<List<ProductoModel>> cargarProducto() async {
    final url = '$_url';
    //solo es necesario cargar el token aqui
    _cabecera["token"] = UsuarioProvider.tokenNode;

    final respuesta = await http.get(url, headers: _cabecera);

    final Map<String, dynamic> decodedData = jsonDecode(respuesta.body);
    final List<ProductoModel> listaProductos = new List<ProductoModel>();
    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "productos") {
        // listaProductos.add(value);
        final List aux = value;
        aux.forEach((e) {
          final temp = ProductoModel.fromJson(e);
          listaProductos.add(temp);
        });
      }
    });
    return listaProductos;
  }

  Future<List<ProductoModel>> buscarProducto(String id) async {
    final url = '$_url/$id';

    final respuesta = await http.get(url, headers: _cabecera);

    final Map<String, dynamic> decodedData = jsonDecode(respuesta.body);
    final List<ProductoModel> listaProductos = new List<ProductoModel>();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "producto") {
        final List aux = value;

        aux.forEach((element) {
          final temp = ProductoModel.fromJson(element);
          temp.proId = element['proId'];
          listaProductos.add(temp);
        });
      }
    });

    return listaProductos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/$id';
    final resp = await http.delete(url, headers: _cabecera);
    if (json.decode(resp.body) != null) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> editarProducto(ProductoModel producto) async {
    // _cabecera["token"] = UsuarioProvider.tokenNode;
    print("Suceso en editar producto" + producto.mostrarProducto());

    final url = '$_url/${producto.proId}';
    final respuesta = await http.put(
      url,
      body: producto.toJson(),
      headers: _cabecera,
    );
    final decodedData = jsonDecode(respuesta.body);
    print("Respuesta de editar producto: $decodedData");
    // print("Status Code: ${respuesta.statusCode}");
    return 0;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dhulr5xwe/image/upload?upload_preset=b1tntub8');

    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);

    final stramResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(stramResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print("Link de foto:\n" + respData['secure_url']);
    return respData['secure_url'];
  }
}
