import 'dart:io';
import 'package:gestiona_facil/src/providers/kardex_existencias_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:gestiona_facil/src/models/kardex_existencia_model.dart';

class KardexExistenciaBloc {
  final _kardexController = new BehaviorSubject<List<KardexExistenciaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _kardexExistenciaProvider = new KardexExistenciasProvider();

  Stream<List<KardexExistenciaModel>> get kardexExistenciaStream =>
      _kardexController.stream;

  Stream<bool> get cargando => _cargandoController.stream;

  void cargarKardexExistencia() async {
    final kardexExistencias =
        await _kardexExistenciaProvider.cargarExistencias();
    _kardexController.sink.add(kardexExistencias);
  }

  dispose() {
    _kardexController.close();
    _cargandoController.close();
  }
}
