import 'package:flutter/material.dart';

class ComplexWidget extends StatefulWidget {
  final String title;
  final List<String> items;

  const ComplexWidget({required this.title, super.key, this.items = const []});

  @override
  State<ComplexWidget> createState() => _ComplexWidgetState();
}

class _ComplexWidgetState extends State<ComplexWidget> {
  int _counter = 0;
  bool _isVisible = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () => setState(() => _isVisible = !_isVisible),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isVisible)
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.items[index]),
                  trailing: const Icon(Icons.arrow_forward),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
