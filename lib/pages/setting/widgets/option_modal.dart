import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OptionModal extends StatelessWidget {
  final String? title;
  final List<dynamic>? options;
  final topBorderRadius = const Radius.circular(12);

  final Widget Function(dynamic)? builder;

  Widget defaultBuilder(dynamic value) {
    return Text('$value');
  }

  const OptionModal({
    Key? key,
    this.title,
    this.options,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText1!,
      child: Material(
        child: SafeArea(
          top: false,
          child: ListView(
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: ClampingScrollPhysics(),
            children: ListTile.divideTiles(
                context: context,
                tiles: (options ?? List.empty()).map(
                  (e) => ListTile(
                    title: (builder ?? defaultBuilder)(e),
                    onTap: () => Navigator.pop(context, e),
                  ),
                )).toList(),
          ),
        ),
      ),
    );
  }
}
