import 'package:flutter/material.dart';

import 'collapsible_menu_bar.dart';

class WrapDemoPage extends StatelessWidget {
  const WrapDemoPage({Key? key}) : super(key: key);

  final List<String> _data = const <String>[
    'Falkenberg',
    'Braga',
    'Stockholm',
    'Trnnava',
    'Plodiv',
    'Klaipeda',
    'Punta Cana',
    'Lisbon',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: MenuBar(
              onItemPressed: (int i) {},
              children: _data
                  .map((String data) => MenuBarItem(
                        onPressed: () => print(data),
                        text: data,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
