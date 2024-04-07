import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/helpers/text_theme_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});
  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 280.0,
            padding: const EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor.withOpacity(0.98),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(bottom: 10.0),
                  child: Text(
                    '提示',
                    style: TextThemeStyle.of(context).fontBold17,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(bottom: 16.0),
                  child: Text(
                    '确认选择精品小班学习吗，选择之后不可更改',
                    textAlign: TextAlign.center,
                    style: TextThemeStyle.of(context)
                        .font16!
                        .copyWith(height: 1.4),
                  ),
                ),
                const BottomButton(),
              ],
            ),
          ),
        ),
      );
}

class BottomButton extends StatelessWidget {
  final bool cancelButton;
  const BottomButton({super.key, this.cancelButton = false});

  Widget _buttonWidget(BuildContext context) {
    if (cancelButton) {
      Row(
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: const EdgeInsets.all(0.0),
              minSize: 52.0,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
          ),
          Container(
            width: 0.5,
            height: 52.0,
            color: ColorTheme.of(context).borderColor,
          ),
          Expanded(
            child: CupertinoButton(
              padding: const EdgeInsets.all(0.0),
              minSize: 52.0,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('确定'),
            ),
          ),
        ],
      );
    }
    return CupertinoButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () => Navigator.of(context).pop(),
      child: const Center(child: Text('确定')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorTheme.of(context).borderColor,
            width: 0.5,
          ),
        ),
      ),
      child: _buttonWidget(context),
    );
  }
}
