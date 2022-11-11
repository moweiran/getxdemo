import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldEmojiDemoPage extends StatefulWidget {
  const TextFieldEmojiDemoPage({Key? key}) : super(key: key);

  @override
  _TextFieldEmojiDemoPageState createState() => _TextFieldEmojiDemoPageState();
}

class _TextFieldEmojiDemoPageState extends State<TextFieldEmojiDemoPage> {
  final int maxLength = 20;
  final double labelFontSize = 18;
  final double inputFontSize = 30;
  final TextEditingController _utf8TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Textfield Emoji Demo'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ..._buildDefaultTextField(),
              const SizedBox(height: 100),
              ..._buildUtf8TextField(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDefaultTextField() {
    return [
      Text(
        'Default length limiter',
        style: TextStyle(fontSize: labelFontSize),
      ),
      TextField(
        maxLength: maxLength,
        style: TextStyle(fontSize: inputFontSize),
      ),
    ];
  }

  List<Widget> _buildUtf8TextField() {
    return [
      Text(
        'UTF8 length limiter',
        style: TextStyle(fontSize: labelFontSize),
      ),
      TextField(
        controller: _utf8TextController,
        maxLength: maxLength,
        style: TextStyle(fontSize: inputFontSize),
        // maxLengthEnforced: false,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          maxLength,
        }) {
          int utf8Length = utf8.encode(_utf8TextController.text).length;
          return Text(
            '$utf8Length/$maxLength',
            style: Theme.of(context).textTheme.caption,
          );
        },
        inputFormatters: [
          _Utf8LengthLimitingTextInputFormatter(maxLength),
        ],
      ),
    ];
  }
}

class _Utf8LengthLimitingTextInputFormatter extends TextInputFormatter {
  _Utf8LengthLimitingTextInputFormatter(this.maxLength)
      : assert(maxLength == -1 || maxLength > 0);

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength > 0 && bytesLength(newValue.text) > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old value.
      if (bytesLength(oldValue.text) == maxLength) {
        return oldValue;
      }
      return truncate(newValue, maxLength);
    }
    return newValue;
  }

  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    var newValue = '';
    if (bytesLength(value.text) > maxLength) {
      var length = 0;

      value.text.characters.takeWhile((char) {
        var nbBytes = bytesLength(char);
        if (length + nbBytes <= maxLength) {
          newValue += char;
          length += nbBytes;
          return true;
        }
        return false;
      });
    }
    return TextEditingValue(
      text: newValue,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, newValue.length),
        extentOffset: min(value.selection.end, newValue.length),
      ),
      composing: TextRange.empty,
    );
  }

  static int bytesLength(String value) {
    return utf8.encode(value).length;
  }
}
