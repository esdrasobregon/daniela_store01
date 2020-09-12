import 'package:daniela_store/models/user.dart';
import 'package:daniela_store/screens/authenticate/authenticate.dart';
import 'package:daniela_store/screens/home/home.dart';
import 'package:daniela_store/screens/products/products_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //returns either the home or authenticate widget
    //

    if (user == null) {
      return Authenticate();
    } else {
      //return Home();
      return ProductHome();
    }
  }
}
