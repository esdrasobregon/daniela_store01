import 'package:daniela_store/models/user.dart';
import 'package:daniela_store/screens/services/database.dart';
import 'package:daniela_store/screens/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String name = '';
  String sugar = '';
  int strength = 100;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            //name = userData.name;
            //strength = userData.strength;
            //sugar = userData.sugars;
            return Form(
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 18.0),
                  TextFormField(
                    initialValue: userData.name,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => name = val),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    hint: Text('${userData.sugars} sugars'),
                    items: this.sugars.map((sugar) {
                      return DropdownMenuItem(
                        child: Text('$sugar sugars'),
                        //_hint = sugar,
                        value: sugar,
                      );
                    }).toList(),
                    onChanged: (val) => sugar = val,
                  ),
                  SizedBox(height: 20.0),
                  Slider(
                    value: (strength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[strength ?? userData.strength],
                    inactiveColor: Colors.brown[strength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => strength = val.round()),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(name == ''){
                        name = userData.name;
                      }
                      if(sugar == ''){
                        sugar = userData.sugars;
                      }
                      await DatabaseService(uid: userData.uid)
                          .updateUserData(this.sugar, this.name, this.strength);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
