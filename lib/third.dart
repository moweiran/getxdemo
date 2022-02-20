import 'package:flutter/material.dart';
import 'package:getxdemo/sencond.dart';
import 'package:getxdemo/store/main_store.dart';
import 'package:provider/provider.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    print('third page build');
    return Container(
      child: Column(
        children: [
          Consumer<MainStoreProvider>(
            builder: (context, value, child) {
              print('third consumer build');
              return Column(
                children: [
                  Text("third consumer count ${value.count}"),
                ],
              );
            },
          ),
          Selector<MainStoreProvider, int>(
            selector: (p0, p1) => p1.count,
            builder: (context, value, w) {
              print('third selector count build');
              return Text("third selector count ${value}");
            },
          ),
          Selector<MainStoreProvider, int>(
            selector: (p0, p1) => p1.secondCount,
            builder: (context, value, w) {
              print('third selector second build');
              return Text("third selector second count ${value}");
            },
          ),
          SecondPage(),
          // Text("${Provider.of<MainStoreProvider>(context).count}"),
        ],
      ),
    );
  }
}
