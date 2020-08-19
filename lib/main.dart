import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bottom.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  runApp(MaterialApp(
    home: email == null ? LoginPage() : MyHomePage(initial: 1,),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new MyHomePage(
            initial: 1,
          ),
      '/login': (BuildContext context) => new LoginPage()
    },
  ));
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue,
//       ),
//       home: LoginPage(),
//     );
//   }
// }
