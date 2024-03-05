import 'package:dynamic_theme/widgets/common/reorderable_list.dart';
import 'package:flutter/material.dart' hide ReorderableListView;

class PositionExchange extends StatefulWidget {
  static const routeName = '/position_exchange';
  const PositionExchange({Key? key}) : super(key: key);

  @override
  State<PositionExchange> createState() => _PositionExchangeState();
}

class _PositionExchangeState extends State<PositionExchange> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(title: const Text('拖动排序')),
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          for (int index = 0; index < _items.length; index += 1)
            ListTile(
              key: Key('$index'),
              tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
              title: Text('Item ${_items[index]}'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
