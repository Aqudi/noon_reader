import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

ItemScrollController useItemScrollController({
  String? debugLabel,
  List<Object?>? keys,
}) {
  return use(
    _ItemScrollControllerHook(
      debugLabel: debugLabel,
      keys: keys,
    ),
  );
}

class _ItemScrollControllerHook extends Hook<ItemScrollController> {
  const _ItemScrollControllerHook({
    this.debugLabel,
    List<Object?>? keys,
  }) : super(keys: keys);

  final String? debugLabel;

  @override
  HookState<ItemScrollController, Hook<ItemScrollController>> createState() =>
      _ItemScrollControllerHookState();
}

class _ItemScrollControllerHookState
    extends HookState<ItemScrollController, _ItemScrollControllerHook> {
  late final controller = ItemScrollController();

  @override
  ItemScrollController build(BuildContext context) => controller;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  String get debugLabel => 'useItemScrollController';
}
