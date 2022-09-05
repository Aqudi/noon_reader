import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noon_reader/models/setting.dart';
import 'package:noon_reader/pages/setting/setting.dart';
import 'package:noon_reader/widgets/viewer_container.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HistoryViewerContainer extends HookConsumerWidget {
  final List<String> content;

  final Future<void> Function()? initializer;
  final Setting? setting;
  final int initialIndex;

  final ScrollPhysics? physics;

  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;

  const HistoryViewerContainer({
    this.content = const [],
    this.initializer,
    this.setting,
    this.initialIndex = 0,
    this.physics,
    this.itemScrollController,
    this.itemPositionsListener,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Text가 초기화 및 initialIndex로 이동 후 보이도록 제어
    final visible = useState(false);

    final textStyle =
        Theme.of(context).textTheme.bodyText1 ?? const TextStyle();

    // 컨트롤러 연결
    useEffect(() {
      if (initializer != null) {
        initializer!().then((value) => visible.value = true);
      }
      return null;
    });

    return Stack(
      children: [
        Container(
          color: setting?.backgroundColor,
          child: DefaultTextStyle(
            style: textStyle,
            child: Column(
              children: [
                Expanded(
                  child: ViewerContainer(
                    key: key,
                    content: content,
                    setting: setting,
                    // 초기화 후 보이도록
                    opacity: visible.value ? 1 : 0,
                    // 초기화 후 스크롤 가능하도록
                    physics: visible.value
                        ? const ClampingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                  ),
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
                      return null;
                    });

                    return Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text("${currentIndex.value}/${content.length}"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: SizedBox(
            width: 45,
            height: 45,
            child: Opacity(
              opacity: 0.5,
              child: FloatingActionButton(
                tooltip: "menu",
                focusColor: Colors.black,
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: const Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
