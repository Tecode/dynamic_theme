import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DiscoveryDetail extends StatefulWidget {
  final String? tag;
  final String? url;
  const DiscoveryDetail({super.key, this.tag, this.url});

  @override
  State<DiscoveryDetail> createState() => _DiscoveryDetailState();
}

class _DiscoveryDetailState extends State<DiscoveryDetail> with SingleTickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  late TapDownDetails _doubleTapDetails;
  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        _controller.value = _animation.value;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _handleDoubleTap() {
    Matrix4 endMatrix;
    if (_controller.value != Matrix4.identity()) {
      endMatrix = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      endMatrix = Matrix4.identity()
        ..translate(-position.dx * 1.3, -position.dy * 1.3)
        ..scale(2.5);
    }
    _animation = Matrix4Tween(
      begin: _controller.value,
      end: endMatrix,
    ).animate(CurveTween(curve: Curves.fastOutSlowIn).animate(_animationController));
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) => Material(
        child: GestureDetector(
          onDoubleTap: _handleDoubleTap,
          onDoubleTapDown: (details) => _doubleTapDetails = details,
          // onTap: () => _controller.value,
          behavior: HitTestBehavior.opaque,
          child: Hero(
            tag: widget.tag ?? '',
            child: Center(
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                transformationController: _controller,
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      Container(color: Theme.of(context).canvasColor),
                  imageUrl: widget.url ?? '',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      );
}
