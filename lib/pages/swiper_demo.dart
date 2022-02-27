import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class ExampleHorizontal extends StatelessWidget {
  const ExampleHorizontal({Key? key}) : super(key: key);
  static List<String> images = [
    "images/1.png",
    "images/2.png",
    "images/3.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ExampleHorizontal"),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          print('===build item');
          return Image.asset(
            images[index],
            fit: BoxFit.fill,
          );
        },
        indicatorLayout: PageIndicatorLayout.SCALE,
        autoplay: true,
        autoplayDelay: 3000,
        itemCount: images.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
        fade: 1.0,
        viewportFraction: 0.85,
      ),
    );
  }
}
