import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    this.proId = '',
    this.proNombre = '',
    this.proIdCategoria = '',
    this.proFoto,
    this.proEstado = '1',
  });

  String proId;
  String proNombre;
  String proIdCategoria;
  String proFoto;
  String proEstado;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        proId: json["proId"].toString(),
        proNombre: json["proNombre"],
        proIdCategoria: json["proIdCategoria"].toString(),
        proFoto: json["proFoto"],
        proEstado: json["proEstado"] == 1 ? '1' : '0',
      );

  Map<String, dynamic> toJson() => {
        "proId": proId,
        "proNombre": proNombre,
        "proIdCategoria": proIdCategoria,
        "proFoto": proFoto,
        "proEstado": proEstado,
      };

  String mostrarProducto() {
    return '\nId: $proId\nNombre: $proNombre\nId Categoría: $proIdCategoria\nFoto: $proFoto';
  }
}
