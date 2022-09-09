import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/models/setting.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomText extends StatelessWidget {
  final int index;
  final String text;
  final TextStyle? style;

  const CustomText(this.index, this.text, {Key? key, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

class ViewerContainer extends HookConsumerWidget {
  final List<String> lines;

  final Setting? setting;
  final double opacity;

  final ScrollPhysics? physics;

  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;

  const ViewerContainer({
    List<String>? content,
    Key? key,
    this.setting,
    this.opacity = 1,
    this.physics,
    this.itemScrollController,
    this.itemPositionsListener,
  })  : lines = content ?? const [],
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    print(textStyle?.fontFamily);
    return DefaultTextStyle(
      style: const TextStyle().merge(textStyle),
      child: Container(
        padding: setting?.padding,
        color: setting?.backgroundColor,
        child: Opacity(
          opacity: opacity,
          child: ScrollablePositionedList.builder(
            key: key,
            physics: physics,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: lines.length,
            itemBuilder: (context, index) {
              return CustomText(index, lines[index]);
            },
          ),
        ),
      ),
    );
  }
}
