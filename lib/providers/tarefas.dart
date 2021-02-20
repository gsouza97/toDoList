import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../providers/tarefa.dart';

class Tarefas with ChangeNotifier {
  final String _baseUrl =
      'https://tasks-app-97291-default-rtdb.firebaseio.com/tarefas';

//  List<Tarefa> _items = DUMMY_TAREFAS;
List<Tarefa> _items = [];

  List<Tarefa> get items {
    return [..._items.reversed];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadTarefas() async {
    final response = await http.get('$_baseUrl.json');
    Map<String, dynamic> data = json.decode(response.body);
    _items.clear();
    if (data != null) {
      data.forEach((tarefaId, tarefaData) {
        _items.add(Tarefa(
          id: tarefaId,
          description: tarefaData['description'],
          isDone: tarefaData['isDone'],
        ));
      });
      notifyListeners();
    }
  }

  Future<void> addTarefa(Tarefa newTarefa) async {
    final response = await http.post(
      '$_baseUrl.json',
      body: json.encode({
        'description': newTarefa.description,
        'isDone': newTarefa.isDone,
      }),
    );

    _items.add(Tarefa(
      id: json.decode(response.body)['name'],
      description: newTarefa.description,
      isDone: newTarefa.isDone,
    ));
    notifyListeners();
  }

  Future<void> deleteTarefa(String id) async {
    final index = _items.indexWhere((tarefa) => tarefa.id == id);
    if (index >= 0) {
      final tarefa = _items[index];
      _items.remove(tarefa);
//      _items.removeWhere((tarefa) => tarefa.id == id);
      notifyListeners();

      final response = await http.delete("$_baseUrl/${tarefa.id}.json");

      if (response.statusCode >= 400) {
        _items.insert(index, tarefa);
        notifyListeners();
      }
    }
  }
}
