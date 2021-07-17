import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoveryDetail extends StatefulWidget {
  final String? tag;
  final String? url;
  const DiscoveryDetail({this.tag, this.url});

  @override
  _DiscoveryDetailState createState() => _DiscoveryDetailState();
}

class _DiscoveryDetailState extends State<DiscoveryDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          behavior: HitTestBehavior.opaque,
          child: Hero(
            tag: widget.tag ?? '',
            child: Center(
              child: InteractiveViewer(
                boundaryMargin: EdgeInsets.all(20.0),
                minScale: 0.1,
                maxScale: 1.6,
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      Container(
                    color: Theme.of(context).backgroundColor,
                  ),
                  imageUrl: widget.url ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      );
}
