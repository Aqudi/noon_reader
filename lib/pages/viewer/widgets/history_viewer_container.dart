import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/widgets/viewer_container.dart';
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

class HistoryViewerContainer extends HookConsumerWidget {
  final String? content;

  final Function(ValueNotifier<bool>)? initializer;
  final Setting? setting;
  final double opacity;
  final int initialIndex;

  final ScrollPhysics? physics;

  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;

  const HistoryViewerContainer({
    this.content,
    this.initializer,
    this.setting,
    this.initialIndex = 0,
    this.opacity = 1,
    this.physics,
    this.itemScrollController,
    this.itemPositionsListener,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lines = useMemoized(() => content?.split("\n")) ?? [];

    // Text가 초기화 및 initialIndex로 이동 후 보이도록 제어
    final visible = useState(false);

    // 컨트롤러 연결
    final defaultViewerContainer = ViewerContainer(
      key: key,
      content: lines,
      setting: setting,
      // 초기화 후 보이도록
      opacity: visible.value ? 1 : 0,
      // 초기화 후 스크롤 가능하도록
      physics: visible.value
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );

    useEffect(() {
      if (initializer != null) {
        initializer!(visible);
      }
      return null;
    });

    return Stack(
      children: [
        Container(
          color: setting?.backgroundColor,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText1 ?? const TextStyle(),
            child: Column(
              children: [
                Expanded(
                  child: defaultViewerContainer,
                ),
                HookBuilder(
                  builder: (context) {
                    final currentIndex = useState(initialIndex);
                    useEffect(() {
                      itemPositionsListener?.itemPositions.addListener(() {
                        final firstIndex = itemPositionsListener
                            ?.itemPositions.value.first.index;
                        if (firstIndex != null) {
                          currentIndex.value = firstIndex;
                        }
                      });
                    });

                    return Container(
                      color: Colors.green,
                      child: Text("${currentIndex.value}/${lines.length}"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: FloatingActionButton(onPressed: () {}),
        ),
      ],
    );
  }
}
