import 'package:chozo_ui_package/chozo_flow/controller.dart';
import 'package:chozo_ui_package/chozo_ui_package.dart';
import 'package:flutter/material.dart';

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
      home: const MyHolder(),
    );
  }
}

class MyHolder extends StatefulWidget {
  const MyHolder({super.key});

  @override
  State<MyHolder> createState() => _MyHolderState();
}

class _MyHolderState extends State<MyHolder> {
  ChozoFlowController controller = ChozoFlowController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: () {
              print(controller.getJson());
            },
            child: Text("output")),
      ),
      body: ChozoFlow(
        controller: controller,
      ),
    );
  }
}
