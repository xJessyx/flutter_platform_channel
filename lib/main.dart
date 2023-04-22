import 'package:flutter/foundation.dart';
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
      home: MyWidget(title: 'test'),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final platform = const MethodChannel('com.example.myApp/myChannel');
  String _message = '';

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((MethodCall call) async {
      if (call.method == "sendMessageFromAndroid") {
        String message = call.arguments;
        if (kDebugMode) {
          print('get android message = $message');
        }
        setState(() {
          _message = message;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Center(
        child: Text('message:$_message'),
      ),
    );
  }
}
