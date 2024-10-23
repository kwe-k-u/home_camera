
import 'package:flutter/material.dart';
import 'package:home_camera/models/camera_stream_url.dart';

class CameraStreamSet extends ChangeNotifier {
  
  final List<CameraStreamUrl> _streams = [];
  

  List<CameraStreamUrl> get streams => _streams;

  void addStream(CameraStreamUrl stream) {
    _streams.add(stream);
    notifyListeners();
  }

  

  void removeStream(CameraStreamUrl stream) {
    _streams.remove(stream);
    notifyListeners();
  }
}