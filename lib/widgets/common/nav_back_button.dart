import 'package:dynamic_theme/helpers/colors.dart';
import 'package:flutter/cupertino.dart';

class NavBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const NavBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      key: const Key('back'),
      onPressed: onTap,
      child: Container(
        width: 42.0,
        padding: const EdgeInsets.only(left: 10.0, right: 20.0),
        child: Image.asset(
          'assets/icons/ic_arrow_left_gray.png',
          color: ColorTheme.of(context).color202326,
        ),
      ),
    );
  }
}
