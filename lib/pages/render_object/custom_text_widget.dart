import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTextWidget extends LeafRenderObjectWidget {
  final String text;
  final Widget? overfollowWidget;
  final int? maxLines;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.overfollowWidget,
    this.maxLines,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _CustomTextRenderBox(text: text);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _CustomTextRenderBox renderObject,
  ) {
    renderObject.text = text;
  }
}

class _CustomTextRenderBox extends RenderShiftedBox {
  _CustomTextRenderBox({
    required String text,
    int? maxLines,
    RenderBox? child,
  })  : _text = text,
        _maxLines = maxLines,
        _textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
          textDirection: TextDirection.ltr,
          ellipsis: '\u2026',
          maxLines: maxLines,
        ),
        super(child);

  String _text;
  String get text => _text;
  set text(String value) {
    if (value == _text) return;
    _text = value;
    markNeedsPaint();
  }

  int? _maxLines;
  int? get maxLines => _maxLines;
  set maxLines(int? value) {
    if (maxLines == value) return;
    _maxLines = value;
    markNeedsPaint();
  }

  @override
  bool get sizedByParent => true;

  final TextPainter _textPainter;

  @override
  void performLayout() {
    // print(constraints.maxHeight);
  }

  List<PlaceholderDimensions>? _placeholderDimensions;

  @override
  void paint(PaintingContext context, Offset offset) {
    final BoxConstraints constraints = this.constraints;
    _placeholderDimensions = [];
    _textPainter.setPlaceholderDimensions(_placeholderDimensions);
    // _setParentData();
    final bool widthMatters = true;
    _textPainter.layout(
      minWidth: constraints.minWidth,
      maxWidth: constraints.maxWidth,
    );
    final Size textSize = _textPainter.size;
    final bool textDidExceedMaxLines = _textPainter.didExceedMaxLines;
    // size = constraints.constrain(textSize);
    final bool didOverflowHeight =
        size.height < textSize.height || textDidExceedMaxLines;
    final bool didOverflowWidth = size.width < textSize.width;
    final bool hasVisualOverflow = didOverflowWidth || didOverflowHeight;
    print(_textPainter.didExceedMaxLines);
    print(_textPainter.size);
    _textPainter.paint(
      context.canvas,
      const Offset(0, 200),
    );
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return Size(constraints.maxWidth, constraints.maxHeight);
  }
}
