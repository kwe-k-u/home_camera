import 'package:flutter/material.dart';

class CameraStreamUrl extends ChangeNotifier {
  String? _url;
  String? _name;

  CameraStreamUrl({String? name, String? url}) {
    _url = url;
    _name = name;
  }

  String? get url => _url;
  String? get name => _name;


  set name(String? newName) {
    _name = newName;
    notifyListeners();
  }

  set url(String? newval) {
    _url = newval;
    notifyListeners();
  }
}
