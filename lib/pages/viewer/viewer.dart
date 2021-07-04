import 'package:flutter/material.dart';

class ViewerPage extends StatelessWidget {
  final String _content;
  ViewerPage({required String content}) : _content = content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noon Reader'),
        centerTitle: true,
      ),
      body: Text(_content),
    );
  }
}
