import 'package:dynamic_theme/helpers/text_theme_style.dart';
import 'package:flutter/material.dart' hide ReorderableListView;

class PositionExchange extends StatefulWidget {
  static const String routeName = '/position-exchange';
  const PositionExchange({Key? key}) : super(key: key);

  @override
  State<PositionExchange> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PositionExchange> {
  final _listViewKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  int _indexOfDroppedItem = 0;
  bool _isDragging = false;
  int _activeItem = -1;

  void _acceptDraggedItem(int index) {
    setState(() {
      _indexOfDroppedItem = index;
    });
  }

  void _setIsDragging() {
    setState(() {
      _isDragging = true;
    });
  }

  void _resetIsDragging() {
    setState(() {
      _isDragging = false;
    });
  }

  void handlePointerMove(PointerMoveEvent event) {
    if (!_isDragging) {
      return;
    }
    RenderBox render = _listViewKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = render.localToGlobal(Offset.zero);
    double topY = position.dy;
    double bottomY = topY + render.size.height;

    // debugPrint("x: ${position.dy}, "
    //     "y: ${position.dy}, "
    //     "height: ${render.size.width}, "
    //     "width: ${render.size.height}");

    const detectedRange = 100;
    const moveDistance = 10;

    if (event.position.dy < topY + detectedRange) {
      var to = _scrollController.offset - moveDistance;
      to = (to < 0) ? 0 : to;
      _scrollController.jumpTo(to);
      debugPrint("top");
    }
    if (event.position.dy > bottomY - detectedRange) {
      debugPrint("bottom ${_scrollController.offset}");
      _scrollController.jumpTo(_scrollController.offset + moveDistance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('拖动排序')),
      body: Listener(
        onPointerMove: handlePointerMove,
        child: ListView(
          controller: _scrollController,
          key: _listViewKey,
          children: const [
            SizedBox(height: 20),
            GirdCardList(title: '封面'),
            GirdCardList(title: '卧室'),
            GirdCardList(title: '卫浴'),
            GirdCardList(title: '外景'),
            GirdCardList(title: '客厅'),
            // DragGirdList(
            //   setIsDragging: _setIsDragging,
            //   resetIsDragging: _resetIsDragging,
            //   indexOfDroppedItem: _indexOfDroppedItem,
            //   isDragging: _isDragging,
            //   activeItem: _activeItem,
            //   onLeave: () => setState(() {
            //     _activeItem = -1;
            //   }),
            //   onAccept: _acceptDraggedItem,
            //   onWillAccept: (int index) {
            //     setState(() {
            //       _activeItem = index;
            //     });
            //     return true;
            //   },
            // ),
            // DragGirdList(
            //   setIsDragging: _setIsDragging,
            //   resetIsDragging: _resetIsDragging,
            //   indexOfDroppedItem: 6,
            //   isDragging: _isDragging,
            //   activeItem: _activeItem,
            //   onLeave: () => setState(() {
            //     _activeItem = -1;
            //   }),
            //   onAccept: _acceptDraggedItem,
            //   onWillAccept: (int index) {
            //     setState(() {
            //       _activeItem = index;
            //     });
            //     return true;
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class DragGirdList extends StatelessWidget {
  final VoidCallback? setIsDragging;
  final VoidCallback? resetIsDragging;
  final VoidCallback? onLeave;
  final Function(int)? onAccept;
  final bool Function(int)? onWillAccept;
  final int indexOfDroppedItem;
  final int activeItem;
  final bool isDragging;
  const DragGirdList({
    Key? key,
    this.setIsDragging,
    this.resetIsDragging,
    this.indexOfDroppedItem = 0,
    this.activeItem = -1,
    this.isDragging = false,
    this.onLeave,
    this.onAccept,
    this.onWillAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 2,
      children: List.generate(6, (index) {
        return Padding(
          padding: const EdgeInsets.all(44.0),
          child: index == indexOfDroppedItem
              ? Draggable<int>(
                  data: index,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  childWhenDragging: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onDragStarted: setIsDragging,
                  onDraggableCanceled: (_, __) => resetIsDragging!(),
                  onDragCompleted: resetIsDragging,
                  feedback: Container(
                    width: 100,
                    height: 100,
                    decoration:
                        const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                )
              : DragTarget<int>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) =>
                      Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: activeItem == index ? Colors.greenAccent : Colors.red),
                      borderRadius: BorderRadius.all(
                        isDragging ? const Radius.circular(20) : const Radius.circular(10),
                      ),
                    ),
                  ),
                  onWillAccept: (_) => onWillAccept!(index),
                  onAccept: (int data) => onAccept!(index),
                  onLeave: (_) => onLeave!(),
                ),
        );
      }),
    );
  }
}

/// 网格布局的卡片
class GirdCardList extends StatelessWidget {
  final String title;
  const GirdCardList({Key? key, this.title = '标题'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 0),
          child: Text('$title (2/10)', style: TextThemeStyle.of(context).fontBold17),
        ),
        DragTarget<int>(
          builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) => GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 3,
            children: List.generate(
              6,
              (index) {
                return Draggable<int>(
                  data: index,
                  child: const DeleteAnimationWidget(),
                  childWhenDragging: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onDragStarted: () => debugPrint('onDragStarted'),
                  // onDraggableCanceled: (_, __) => resetIsDragging!(),
                  // onDragCompleted: resetIsDragging,
                  feedback: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                );
              },
            ),
          ),
          onWillAccept: (_) {
            debugPrint('onWillAccept');
            return true;
          },
          onAccept: (int data) => {},
          onLeave: (_) => {},
        ),
      ],
    );
  }
}

class DeleteAnimationWidget extends StatefulWidget {
  const DeleteAnimationWidget({Key? key}) : super(key: key);

  @override
  _DeleteAnimationWidgetState createState() => _DeleteAnimationWidgetState();
}

class _DeleteAnimationWidgetState extends State<DeleteAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween(begin: -0.05, end: 0.05).animate(_controller);
    Future.microtask(_startDeleteAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startDeleteAnimation() {
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startDeleteAnimation,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(angle: _animation.value, child: child);
        },
        child: Container(
          margin: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
            color: Colors.red,
            // border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Center(
            child: Icon(Icons.delete, color: Colors.white, size: 50.0),
          ),
        ),
      ),
    );
  }
}
