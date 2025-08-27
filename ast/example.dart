import 'package:flutter/material.dart';

class AppComponent extends StatelessWidget {
  const AppComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Hello")),
        body: Center(
          child: Column(
            children: [
              const Text("Welcome"),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Click Me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
