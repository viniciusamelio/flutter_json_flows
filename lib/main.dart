import 'package:dynamic_flows/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Flows Example',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const DynamicView(),
    );
  }
}
