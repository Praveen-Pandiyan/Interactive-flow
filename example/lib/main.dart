import 'package:chozo_ui_package/chart/chart.dart';
import 'package:chozo_ui_package/chozo_ui_package.dart';
import 'package:flutter/material.dart';

import 'chart/chart.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const ChozoFlow(),
    );
  }
}

class Holder extends StatefulWidget {
  const Holder({super.key});

  @override
  State<Holder> createState() => _HolderState();
}

class _HolderState extends State<Holder> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: false,
      body: Column(
        children: [SizedBox(height: 100), ChartView()],
      ),
    );
  }
}
