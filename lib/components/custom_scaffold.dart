import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? titleWidget;
  final Widget? floatingActionButton;
  const CustomScaffold({
    Key? key,
    required this.body,
    this.title,
    this.titleWidget,
    this.floatingActionButton,
  })  : assert(title != null || titleWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null && title!.isNotEmpty ? Text(title!) : titleWidget,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
