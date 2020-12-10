import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:gestiona_facil/src/detector_objetos/camera_helper.dart';

import 'package:gestiona_facil/src/detector_objetos/tflite_helper.dart';
import 'package:gestiona_facil/src/models/resultado_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ComprasPage extends StatefulWidget {
  @override
  _ComprasPageState createState() => _ComprasPageState();
}

//with TickerProviderStateMixin
class _ComprasPageState extends State<ComprasPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool isCameraReady = false;
  bool showCapturePhoto = false;
  List<Resultado> _outputs;
  AnimationController _colorAnimController;
  Animation _colorTween;

  List<String> productos = new List<String>();

  @override
  void initState() {
    super.initState();
    TFLiteHelper.loadModel().then((value) {
      setState(() {
        TFLiteHelper.modelLoaded = true;
      });
    });
    CameraHelper.initializeCamera();
    _setupAnimation();
    TFLiteHelper.tfLiteResultsController.stream.listen(
        (event) {
          event.forEach((element) {
            _colorAnimController.animateTo(element.confidence,
                curve: Curves.bounceIn, duration: Duration(milliseconds: 500));
          });
          _outputs = event;
          setState(() {
            CameraHelper.isDetecting = false;
          });
        },
        onDone: () {},
        onError: (err) {
          print(err);
        });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (CameraHelper.camera != null) {
        CameraHelper.initializeControllerFuture =
            CameraHelper.camera.initialize();
      } else {
        CameraHelper.disposeCamera();
      }
      //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compras Page'),
      ),
      body: _cameraPreview(),
      floatingActionButton: _crearBotones(),
    );
  }

  Widget _cameraPreview() {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<void>(
      future: CameraHelper.initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Center(
            child: Transform.scale(
              scale: CameraHelper.camera.value.aspectRatio / deviceRatio,
              child: Stack(
                  // padding: EdgeInsets.only(bottom: 60, top: 0, left: 0, right: 100),
                  children: [
                    AspectRatio(
                      aspectRatio: CameraHelper.camera.value.aspectRatio,
                      child: CameraPreview(CameraHelper.camera), //cameraPreview
                    ),
                    _buildResultsWidget(width, _outputs)
                    // Center(
                    //   child: Container(
                    //     child: Text('Soy un Intruso'),
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ]),
            ),
          );
        } else {
          return Center(
              child:
                  CircularProgressIndicator()); // Otherwise, display a loading indicator.
        }
      },
    );
  }

  Widget _crearBotones() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'listaCompras',
                    arguments: productos);
              },
              child: Icon(Icons.arrow_forward),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 30.0,
            ),
            FloatingActionButton(
              onPressed: () {
                print('refresh');
              },
              child: Icon(Icons.refresh),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: SizedBox(
                width: 5.0,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                print('remove');
              },
              child: Icon(Icons.remove),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 5.0,
            ),
            FloatingActionButton(
              onPressed: () {
                productos.add(_outputs.last.label);
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 70,
        ),
      ],
    );
  }

  Widget _buildResultsWidget(double width, List<Resultado> outputs) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 100.0,
          width: width,
          color: Colors.white,
          child: outputs != null && outputs.isNotEmpty
              ? ListView.builder(
                  itemCount: outputs.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (BuildContext context, int index) {
                    // productos.add(outputs[index].label.toString());
                    return Column(
                      children: <Widget>[
                        Text(
                          outputs[index].label,
                          style: TextStyle(
                            color: _colorTween.value,
                            fontSize: 10.0,
                          ),
                        ),
                        AnimatedBuilder(
                            animation: _colorAnimController,
                            builder: (context, child) => LinearPercentIndicator(
                                  width: width * 0.8,
                                  lineHeight: 5.0,
                                  percent: outputs[index].confidence,
                                  progressColor: _colorTween.value,
                                )),
                        Text(
                          "${(outputs[index].confidence * 100.0).toStringAsFixed(2)} %",
                          style: TextStyle(
                            color: _colorTween.value,
                            fontSize: 6.0,
                          ),
                        ),
                      ],
                    );
                  })
              : Center(
                  child: Text("Espera Por favor :v",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ))),
        ),
      ),
    );
  }

  void _setupAnimation() {
    _colorAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5),
    );
    _colorTween = ColorTween(begin: Colors.green, end: Colors.red)
        .animate(_colorAnimController);
  }

  @override
  void dispose() {
    CameraHelper.camera?.dispose();
    super.dispose();
  }
}
