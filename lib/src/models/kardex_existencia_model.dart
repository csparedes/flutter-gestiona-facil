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
    this.keFechaCaducidad,
    this.keCantidad,
    this.keValorPromedio,
    this.keValorTotal,
    this.keEstado,
  });

  String keId;
  String keProId;
  String keFechaCaducidad;
  int keCantidad;
  double keValorPromedio;
  double keValorTotal;
  String keEstado;

  factory KardexExistenciaModel.fromJson(Map<String, dynamic> json) =>
      KardexExistenciaModel(
        keId: json["keId"],
        keProId: json["keProId"],
        keFechaCaducidad: json["keFechaCaducidad"],
        keCantidad: json["keCantidad"],
        keValorPromedio: json["keValorPromedio"].toDouble(),
        keValorTotal: json["keValorTotal"].toDouble(),
        keEstado: json["keEstado"],
      );

  Map<String, dynamic> toJson() => {
        "keId": keId,
        "keProId": keProId,
        "keFechaCaducidad": keFechaCaducidad,
        "keCantidad": keCantidad,
        "keValorPromedio": keValorPromedio,
        "keValorTotal": keValorTotal,
        "keEstado": keEstado,
      };
}
