import 'package:flutter/material.dart';

class CloseDialog extends StatefulWidget {
  final Function endLive;
  const CloseDialog({Key? key, required this.endLive}) : super(key: key);

  @override
  State<CloseDialog> createState() => _CloseDialogState();
}

class _CloseDialogState extends State<CloseDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: () {
          widget.endLive();
        },
        child: const Text('close'),
      ),
    );
  }
}
