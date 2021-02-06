import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Configurações'),
            automaticallyImplyLeading: false,
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              'Informações',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationLegalese:
                      'Developed by Gabriel Souza\ngithub.com/gsouza97\n2021',
                  applicationVersion: 'Version 1.0.1');
            },
          ),
        ],
      ),
    );
  }
}
