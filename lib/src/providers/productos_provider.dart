import 'dart:convert';
import 'dart:io';
import 'package:gestiona_facil/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class ProductosProvider {
  final String _url =
      'https://appmovil.gestionafacil.ibx.lat/viveres_stalin/public/productos';
  // final _prefs = new PreferenciasUsuario();
  final Map<String, String> _cabecera = {
    "Accept": "*/*",
    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    // "User-Agent": "PostmanRuntime/7.26.8",
  };

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url';
    final respuesta = await http.post(
      url,
      body: codificacionUrlEncoded(producto),
      headers: _cabecera,
    );
    print(json.decode(respuesta.body));
    return true;
  }

  Future<List<ProductoModel>> cargarProducto() async {
    final url = '$_url';

    final respuesta = await http.get(url);

    final Map<String, dynamic> decodedData = jsonDecode(respuesta.body);
    final List<ProductoModel> listaProductos = new List<ProductoModel>();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "data") {
        final List aux = value;

        aux.forEach((element) {
          final temp = ProductoModel.fromJson(element);
          temp.prodId = element['prod_id'];
          temp.prodCodigo = element['prod_codigo'];
          temp.prodNombreProducto = element['prod_nombreProducto'];
          temp.prodFechaCaducidad = element['prod_fechaCaducidad'];
          temp.prodPrecioCompra = element['prod_precioCompra'];
          temp.prodPrecioVenta = element['prod_precioVenta'];
          temp.prodFotoUrl = element['prod_fotoUrl'];
          temp.prodDisponible = element['prod_disponible'];
          listaProductos.add(temp);
        });
      }
    });

    return listaProductos;
  }

  Future<List<ProductoModel>> buscarProducto(String id) async {
    final url = '$_url/$id';

    final respuesta = await http.get(url);

    final Map<String, dynamic> decodedData = jsonDecode(respuesta.body);
    final List<ProductoModel> listaProductos = new List<ProductoModel>();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "data") {
        final List aux = value;

        aux.forEach((element) {
          final temp = ProductoModel.fromJson(element);
          temp.prodId = element['prod_id'];
          listaProductos.add(temp);
        });
      }
    });

    return listaProductos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/$id';
    final resp = await http.delete(url);
    if (json.decode(resp.body) != null) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> editarProducto(ProductoModel producto) async {
    final url = '$_url/${producto.prodId}';
    final respuesta = await http.put(
      url,
      body: codificacionUrlEncoded(producto),
      headers: _cabecera,
    );
    final decodedData = jsonDecode(respuesta.body);
    print("Respuesta de editar producto: $decodedData");
    print("Status Code: ${respuesta.statusCode}");
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

    return respData['secure_url'];
  }
}
