import 'dart:async';
import 'package:camera/camera.dart';

import 'package:gestiona_facil/src/models/resultado_model.dart';
import 'package:tflite/tflite.dart';

class TFLiteHelper {
  static StreamController<List<Resultado>> tfLiteResultsController =
      new StreamController.broadcast();
  static List<Resultado> _outputs = List();
  static var modelLoaded = false;

  static Future<String> loadModel() async {
    // AppHelper.log("loadModel", "Loading model..");

    return Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  static classifyImage(CameraImage image) async {
    await Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            numResults: 5)
        .then((value) {
      if (value.isNotEmpty) {
        // AppHelper.log("classifyImage", "Resultados Cargados. ${value.length}");

        //Clear previous results
        _outputs.clear();

        value.forEach((element) {
          _outputs.add(Resultado(
              element['confidence'], element['index'], element['label']));

          // AppHelper.log("classifyImage",
          //     "Resultado de la Clasificación: ${element['confidence']} , ${element['index']}, ${element['label']}");
        });
      }

      //Sort results according to most confidence
      _outputs.sort((a, b) => a.confidence.compareTo(b.confidence));

      //Send results
      tfLiteResultsController.add(_outputs);
    });
  }

  static void disposeModel() {
    Tflite.close();
    tfLiteResultsController.close();
  }
}
