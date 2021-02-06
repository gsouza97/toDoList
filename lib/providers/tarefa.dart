import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tarefa with ChangeNotifier {
  final String id;
  final String description;
  bool isDone;

  Tarefa({
    this.id,
    @required this.description,
    this.isDone = false,
  });

  final String _baseUrl =
      'https://tasks-app-97291-default-rtdb.firebaseio.com/tarefas';

  Future<void> toggleDone(bool value) async {
    final url = '$_baseUrl/$id.json';
    await http.patch(
      url,
      body: jsonEncode({
        'isDone': isDone,
      }),
    );
    isDone = value;
    notifyListeners();
  }
}
