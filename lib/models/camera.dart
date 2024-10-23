import 'package:flutter/material.dart';

class Camera {
  String cameraId;
  String cameraName;

  Camera({required this.cameraId, required this.cameraName});
}

class CameraSet extends ChangeNotifier {
  final List<Camera> _cameras = [];

  void addCamera(Camera camera) {
    _cameras.add(camera);
    notifyListeners();
  }

  List<Camera> get cameras => _cameras;
}
