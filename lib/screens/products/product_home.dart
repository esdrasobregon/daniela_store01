import 'package:daniela_store/models/brews.dart';
import 'package:daniela_store/models/user.dart';
import 'package:daniela_store/screens/products/pruductInfo.dart';
import 'package:daniela_store/screens/services/auth.dart';
import 'package:daniela_store/screens/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSettings extends StatefulWidget {
  @override
  _ProductSettingsState createState() => _ProductSettingsState();
}

class _ProductSettingsState extends State<ProductSettings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Daniela store'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Logout'),
              ),
              FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          body: Column(children: <Widget>[
            ProductInfoForm(),
            RaisedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ])),
    );
  }
}