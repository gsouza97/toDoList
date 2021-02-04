import 'package:flutter/material.dart';

class Tarefa with ChangeNotifier {
  final String id;
  final String description;
  bool isDone;

  Tarefa({
    this.id,
    @required this.description,
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
    notifyListeners();
  }
}
