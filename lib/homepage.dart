import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  PickedFile? _image;
  List<dynamic>? _outputs;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
  }

  void _loadModel() async {
    await Tflite.loadModel(
      model: "assets/Curcuma/model_curcumalonga.tflite",
      labels: "assets/Curcuma/labelscurcumalonga.txt",
    );
  }

  void _loadModel2() async {
    await Tflite.loadModel(
      model: "assets/Curcuma/model_curcumaamada.tflite",
      labels: "assets/Curcuma/labelscurcumaamada.txt",
    );
  }

  void _loadModel3() async {
    await Tflite.loadModel(
      model: "assets/Curcuma/model_curcumacasia.tflite",
      labels: "assets/Curcuma/labelscurcumacasia.txt",
    );
  }

  void _loadModel4() async {
    await Tflite.loadModel(
      model: "assets/Curcuma/model_curcumazeodaria.tflite",
      labels: "assets/Curcuma/labelscurcumazeodaria.txt",
    );
  }

  classifyImage(image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1,
        threshold: 0.5,
        imageMean: 0.0,
        imageStd: 255.0,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TFLite Model Testing'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 120),
                        RaisedButton(
                          onPressed: () => [_loadModel(), _optiondialogbox()],
                          child: Text("TEST For CURCUMA LONGA"),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () => [_loadModel2(), _optiondialogbox()],
                          child: Text("TEST For CURCUMA AMADA"),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () => [_loadModel3(), _optiondialogbox()],
                          child: Text("TEST For CURCUMA CASIA"),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () => [_loadModel4(), _optiondialogbox()],
                          child: Text("TEST For CURCUMA ZEODARIA"),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 10),
                      ]),
                ),
                _image == null
                    ? Container()
                    : Image.file(File(_image!.path), width: 500, height: 400),
                SizedBox(
                  height: 10,
                ),
                _outputs != null
                    ? Text(
                        '${_outputs![0]["label"]}',
                         style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          background: Paint()..color = Colors.white,
                        ),
                      )
                  : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _optiondialogbox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: Text(
                        "Take A Picture",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onTap: () => [
                            openCamera(),
                            Navigator.of(context, rootNavigator: true).pop()
                          ]),
                  Padding(padding: EdgeInsets.all(10.0)),
                  GestureDetector(
                      child: Text(
                        "Select Image From Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 21.0),
                      ),
                      onTap: () => [
                            openGallery(),
                            Navigator.of(context, rootNavigator: true).pop()
                          ])
                ],
              ),
            ),
          );
        });
  }

  Future openCamera() async {
    var image = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    classifyImage(_image);
  }

  Future openGallery() async {
    var piture = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = piture;
    });
    classifyImage(_image);
  }
}
