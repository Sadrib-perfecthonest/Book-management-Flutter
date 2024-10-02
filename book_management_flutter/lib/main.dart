import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _token;

  @override
  void initState() {
    super.initState();
    // Initialize the token to an empty string
    _token = '';
  }

  // Function to update the token
  void updateToken(String token) {
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Pass the token to the generateRoute method
        return Routes.generateRoute(settings, _token);
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
