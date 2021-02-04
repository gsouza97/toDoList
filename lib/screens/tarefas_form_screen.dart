import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasks/providers/tarefa.dart';
import 'package:tasks/providers/tarefas.dart';

class TarefasFormScreen extends StatefulWidget {
  @override
  _TarefasFormScreenState createState() => _TarefasFormScreenState();
}

class _TarefasFormScreenState extends State<TarefasFormScreen> {
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  final _descriptionFocusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _descriptionFocusNode.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    final tarefa = Tarefa(
      description: _formData['description'],
    );

    setState(() {
      _isLoading = true;
    });

    final tarefas = Provider.of<Tarefas>(context, listen: false);
    {
      await tarefas.addTarefa(tarefa);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nova Tarefa'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      // initialValue: _formData['description'],
                      decoration: InputDecoration(labelText: 'Descrição'),
                      focusNode: _descriptionFocusNode,
                      textInputAction: TextInputAction.done,
                      onSaved: (value) => _formData['description'] = value,
                      maxLines: 3,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Informe uma tarefa';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
