import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefa.dart';

class TarefaItem extends StatefulWidget {
  @override
  _TarefaItemState createState() => _TarefaItemState();
}

class _TarefaItemState extends State<TarefaItem> {
  @override
  Widget build(BuildContext context) {
    final Tarefa tarefa = Provider.of<Tarefa>(context, listen: true);

    return Column(
      children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: (Text(tarefa.description)),
          value: tarefa.isDone,
          onChanged: (bool value) {
            setState(() {
              tarefa.isDone = value;
              tarefa.toggleDone(value);
            });
          },
        ),
        Divider(
          color: Colors.black26,
        ),
      ],
    );
  }
}
