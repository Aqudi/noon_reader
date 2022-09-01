import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

ItemPositionsListener useItemPositionsListener({
  String? debugLabel,
  List<Object?>? keys,
}) {
  return use(
    _ItemPositionsListenerHook(
      debugLabel: debugLabel,
      keys: keys,
    ),
  );
}

class _ItemPositionsListenerHook extends Hook<ItemPositionsListener> {
  const _ItemPositionsListenerHook({
    this.debugLabel,
    List<Object?>? keys,
  }) : super(keys: keys);

  final String? debugLabel;

  @override
  HookState<ItemPositionsListener, Hook<ItemPositionsListener>> createState() =>
      _ItemPositionsListenerHookState();
}

class _ItemPositionsListenerHookState
    extends HookState<ItemPositionsListener, _ItemPositionsListenerHook> {
  late final listener = ItemPositionsListener.create();

  @override
  ItemPositionsListener build(BuildContext context) => listener;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  String get debugLabel => 'useItemPositionsListener';
}
