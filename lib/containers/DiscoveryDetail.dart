import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_theme/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoveryDetail extends StatefulWidget {
  final String tag;
  final String url;
  DiscoveryDetail({this.tag, this.url});

  @override
  _DiscoveryDetailState createState() => _DiscoveryDetailState();
}

class _DiscoveryDetailState extends State<DiscoveryDetail> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Hero(
          tag: widget.tag,
          child: Center(
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Container(
                color: ColorTheme.of(context).colorF3F3F6,
              ),
              imageUrl: widget.url,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
