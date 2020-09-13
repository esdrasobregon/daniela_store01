import 'package:flutter/material.dart';

class ProductInfoForm extends StatefulWidget {
  @override
  _ProductInfoFormState createState() => _ProductInfoFormState();
}

class _ProductInfoFormState extends State<ProductInfoForm> {
  String vCountry, vCity, vProvince, vEmail, vAdicionalData;
  int vRadNewCard, vRadExCard, vRadTransference;
  TextEditingController _countryCon,
      _cityCon,
      _provinceCon,
      _additionalCon,
      _emailIcon;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          _textField(null, true, this.vProvince, 'Product name', _provinceCon),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
            },
            child: Text('Submit'),
          ),
        ]));
  }

  Widget _textField(String pdefaultValue, bool pFieldReq, String pField,
      String phint, TextEditingController controller,
      [bool obscure = false]) {
    var border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(7),
      ),
    );

    return TextFormField(
      validator: (val) {
        if (pdefaultValue != null) {}
        if (!val.isEmpty) {
          pField = val;
          print(pField);
        } else {
          if (pFieldReq) {
            return 'Enter $phint';
          } else {
            pField = '';
          }
        }
        return null;
      },
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        labelText: phint,
        labelStyle: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        hintText: phint,
        hintStyle: TextStyle(color: Theme.of(context).accentColor),
        focusedBorder: border,
        border: border,
        enabledBorder: border,
      ),
    );
  }
}
