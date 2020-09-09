import 'package:daniela_store/screens/services/auth.dart';
import 'package:flutter/material.dart';

class SingIn extends StatefulWidget {
  final Function togleView;

  SingIn({Key key, this.togleView});
  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Daniela store'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              widget.togleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    this.email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    this.password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    dynamic result = await await _auth
                        .signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        this.error = 'Please suply a valid email';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20.0),
              Text(
                this.error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
        // child:
      ),
    );
  }
}
