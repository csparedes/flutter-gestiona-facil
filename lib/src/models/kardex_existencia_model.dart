// To parse this JSON data, do
//
//     final kardexExistenciaModel = kardexExistenciaModelFromJson(jsonString);

import 'dart:convert';

KardexExistenciaModel kardexExistenciaModelFromJson(String str) =>
    KardexExistenciaModel.fromJson(json.decode(str));

String kardexExistenciaModelToJson(KardexExistenciaModel data) =>
    json.encode(data.toJson());

class KardexExistenciaModel {
  KardexExistenciaModel({
    this.keId,
    this.keProId,
    this.keProNombre,
    this.keFechaCaducidad,
    this.keCantidad,
    this.keValorUnitario,
    this.keValorTotal,
    this.keEstado,
  });

  String keId;
  String keProId;
  String keProNombre;
  String keFechaCaducidad;
  int keCantidad;
  double keValorUnitario;
  double keValorTotal;
  String keEstado;

  factory KardexExistenciaModel.fromJson(Map<String, dynamic> json) =>
      KardexExistenciaModel(
        keId: json["keId"].toString(),
        keProId: json["keProId"].toString(),
        keProNombre: json['keProNombre'].toString(),
        keFechaCaducidad: json["keFechaCaducidad"].toString(),
        keCantidad: json["keCantidad"],
        keValorUnitario: json["keValorUnitario"].toDouble(),
        keValorTotal: json["keValorTotal"].toDouble(),
        keEstado: json["keEstado"] == 1 ? '1' : '0',
      );

  Map<String, dynamic> toJson() => {
        "keId": keId,
        "keProId": keProId,
        "keProNombre": keProNombre,
        "keFechaCaducidad": keFechaCaducidad,
        "keCantidad": keCantidad,
        "keValorPromedio": keValorUnitario,
        "keValorTotal": keValorTotal,
        "keEstado": keEstado,
      };

  String mostrarExistencia() {
    return "\nID: $keId\nProducto ID: $keProId\nCaducidad: $keFechaCaducidad\nNombre: $keProNombre\nValor Unitario: $keValorUnitario\nValor Total: $keValorTotal";
  }
}
