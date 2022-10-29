import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'placeholders.dart';

class ShimmerDemoPage extends StatefulWidget {
  const ShimmerDemoPage({Key? key}) : super(key: key);

  @override
  State<ShimmerDemoPage> createState() => _ShimmerDemoPageState();
}

class _ShimmerDemoPageState extends State<ShimmerDemoPage> {
  final bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading List'),
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: const [
              BannerPlaceholder(),
              TitlePlaceholder(width: double.infinity),
              // SizedBox(height: 16.0),
              // ContentPlaceholder(
              //   lineType: ContentLineType.threeLines,
              // ),
              // SizedBox(height: 16.0),
              // TitlePlaceholder(width: 200.0),
              // SizedBox(height: 16.0),
              // ContentPlaceholder(
              //   lineType: ContentLineType.twoLines,
              // ),
              // SizedBox(height: 16.0),
              // TitlePlaceholder(width: 200.0),
              // SizedBox(height: 16.0),
              // ContentPlaceholder(
              //   lineType: ContentLineType.twoLines,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
