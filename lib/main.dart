import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import './providers/tarefas.dart';
import './utils/app_routes.dart';
import './screens/tarefas_form_screen.dart';
import './screens/tarefas_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Tarefas(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        home: SplashScreenView(
          home: TarefasScreen(),
          duration: 4000,
          imageSize: 100,
          imageSrc: 'assets/images/logo.png',
          text: 'To Do App',
          textStyle: TextStyle(fontSize: 30),
          textType: TextType.TyperAnimatedText,
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
        ),
        routes: {
          //AppRoutes.TAREFAS_SCREEN: (ctx) => TarefasScreen(),
          AppRoutes.TAREFAS_FORM: (ctx) => TarefasFormScreen(),
        },
      ),
    );
  }
}
