import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => jsonEncode(data.toJson());

String codificacionUrlEncoded(ProductoModel data) {
  String salida = '';
  salida +=
      'prod_codigo=${data.prodCodigo}&prod_nombreProducto=${_reemplazarEspacios(data.prodNombreProducto)}&prod_fechaCaducidad=${data.prodFechaCaducidad}&prod_precioCompra=${data.prodPrecioCompra.toString()}&prod_precioVenta=${data.prodPrecioVenta.toString()}&prod_fotoUrl=${data.prodFotoUrl}&prod_disponible=${data.prodDisponible}';
  return salida;
}

String _reemplazarEspacios(String lol) {
  return lol.replaceAll(' ', '%20');
}

class ProductoModel {
  String prodId;
  String prodCodigo;
  String prodNombreProducto;
  String prodFechaCaducidad;
  String prodPrecioCompra;
  String prodPrecioVenta;
  String prodFotoUrl;
  String prodDisponible;

  ProductoModel({
    this.prodId = '',
    this.prodCodigo = '',
    this.prodNombreProducto = '',
    this.prodFechaCaducidad = '',
    this.prodPrecioCompra = '',
    this.prodPrecioVenta = '',
    this.prodFotoUrl =
        'https://www.pequenomundo.cl/wp-content/themes/childcare/images/default.png',
    this.prodDisponible = '1',
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
      prodId: json["prod_id"],
      prodCodigo: json["prod_codigo"],
      prodNombreProducto: json["prod_nombreProducto"],
      prodFechaCaducidad: json["prod_fechaCaducidad"],
      prodPrecioCompra: json["prod_precioCompra"],
      prodPrecioVenta: json["prod_precioVenta"],
      prodFotoUrl: json["prod_fotoUrl"],
      prodDisponible: json["prod_disponible"]);

  Map<String, dynamic> toJson() => {
        "prod_id": prodId,
        "prod_codigo": prodCodigo,
        "prod_nombreProducto": prodNombreProducto,
        "prod_fechaCaducidad": prodFechaCaducidad,
        "prod_precioCompra": prodPrecioCompra,
        "prod_precioVenta": prodPrecioVenta,
        "prod_fotoUrl": prodFotoUrl,
        "prod_disponible": prodDisponible,
      };
}
