import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CircleLogoWidget extends SingleChildRenderObjectWidget {
  const CircleLogoWidget({Key? key}) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CircleLogoRenderBox();
  }
}

class CircleLogoRenderBox extends RenderConstrainedBox {
  CircleLogoRenderBox()
      : super(additionalConstraints: const BoxConstraints.tightForFinite());

  @override
  void paint(PaintingContext context, Offset offset) {
    Paint _paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    TextSpan logoSpan = const TextSpan(
      text: 'OldBirds',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 16,
      ),
    );

    TextPainter textPainter = TextPainter(
      text: logoSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: 180);

    textPainter.paint(
      context.canvas,
      Offset(-textPainter.size.width / 2, -textPainter.size.height / 2),
    );

    context.canvas.drawCircle(offset, 80, _paint);
  }
}
