import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyFlutterApp(title: 'test'),
    );
  }
}

const platform = MethodChannel('com.example.myapp/message');

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _MyFlutterAppState createState() => _MyFlutterAppState();
}

class _MyFlutterAppState extends State<MyFlutterApp> {
  String message = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      final String result = await platform.invokeMethod('getMessage');
      setState(() {
        message = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        message = "Failed to get message: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("message = $message"),
        ),
      ),
    );
  }
}
