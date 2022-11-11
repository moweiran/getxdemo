import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyAlignWidget extends SingleChildRenderObjectWidget {
  final AlignmentGeometry alignment;

  const MyAlignWidget({
    Key? key,
    this.alignment = Alignment.center,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  SingleChildRenderObjectElement createElement() {
    return super.createElement();
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    // TODO: implement updateRenderObject
    super.updateRenderObject(context, renderObject);
  }
}

class MyAlignRenderBox extends RenderShiftedBox {
  final AlignmentGeometry alignment;

  MyAlignRenderBox(
    RenderBox child,
    this.alignment,
  ) : super(child);

  @override
  void performLayout() {
    
  }
}
