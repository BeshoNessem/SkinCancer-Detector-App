import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/NavBar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite/tflite.dart';

class ToImage extends StatefulWidget {
  const ToImage({Key? key}) : super(key: key);

  @override
  _ToImageState createState() => _ToImageState();
}

class _ToImageState extends State<ToImage> {
  late File _image;
  late List _results;
  bool imageSelect = false;
  String? _url;
  String?postID;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/images/model.tflite",
        labels: "assets/images/labels.txt"))!;
    print("Model loading status:$res");
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          "SC Detector",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
            children: [
              (imageSelect)
                  ? Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.file(_image),
                    )
                  : Container(
                      margin: const EdgeInsets.all(10),
                      child: const Opacity(
                        opacity: 0.8,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 200),
                            child: Text(
                              "No image selected",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
              SingleChildScrollView(
                child: Column(
                  children: (imageSelect)
                      ? _results.map((result) {
                          return Card(
                            elevation: 10,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Prediction:${result['label']} \nConfidence:${result['confidence'] * 100}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }).toList()
                      : [],
                ),
              ),
            ],
          ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        children: [
          SpeedDialChild(
              child: Icon(Icons.camera_alt),
              label: "Take Photo",
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              onTap: takeImage),
          SpeedDialChild(
              child: Icon(Icons.image),
              label: "Upload Photo",
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              onTap: pickImage),
          SpeedDialChild(
              child: Icon(Icons.save),
              label: "Save",
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              onTap: () {
                uploadImage();
              })
        ],
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }

  Future takeImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }

  Future uploadImage() async {
    final postID = DateTime.now().toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance.ref().child("${user.uid}/images").child("post_$postID");
    await ref.putFile(_image);
    _url = await ref.getDownloadURL();
    await firebaseFirestore.collection("users").doc(user.uid).collection("images").add({'imageUrl': _url,'Time':postID,'Label':_results[0]['label']});
  }
}
