import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas.dart';
import '../utils/app_routes.dart';
import '../widgets/my_drawer.dart';
import '../widgets/tarefa_item.dart';

class TarefasScreen extends StatefulWidget {
  //final List<Tarefa> loadedTarefas = DUMMY_TAREFAS;

  @override
  _TarefasScreenState createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Tarefas>(context, listen: false).loadTarefas().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshTarefas(BuildContext context) async {
    await Provider.of<Tarefas>(context, listen: false).loadTarefas();
  }

  @override
  Widget build(BuildContext context) {
    final tarefasProvider =
        Provider.of<Tarefas>(context); //list tarefas de provider
    final tarefas = tarefasProvider.items; //lista de tarefas
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To Do App'),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: RefreshIndicator(
          onRefresh: () => _refreshTarefas(context),
          child: tarefas.isEmpty
              ? Center(
                  child: Text(
                    'Não há nada para fazer!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'To Do:',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: tarefasProvider.itemsCount,
                              itemBuilder: (ctx, index) =>
                                  ChangeNotifierProvider.value(
                                value: tarefas[index],
                                child: Dismissible(
                                  key: ValueKey(tarefas[index].id),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Theme.of(context).errorColor,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(right: 20),
                                  ),
                                  onDismissed: (direction) {
                                    tarefasProvider
                                        .deleteTarefa(tarefas[index].id);
                                    Scaffold.of(ctx).hideCurrentSnackBar();
                                    Scaffold.of(ctx).showSnackBar(
                                      SnackBar(
                                        content: Text('Tarefa excluida!'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: TarefaItem(),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.TAREFAS_FORM);
        },
      ),
    );
  }
}
