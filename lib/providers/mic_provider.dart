import 'package:flutter/material.dart';

class MicProvider extends ChangeNotifier {
   bool _micOn = false;
   bool get micOn => _micOn;
  void setMic(bool status) {
    _micOn = status;
    notifyListeners();
  }
}