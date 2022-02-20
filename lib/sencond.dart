import 'package:flutter/material.dart';
import 'package:getxdemo/store/main_store.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SencondPageState createState() => _SencondPageState();
}

class _SencondPageState extends State<SecondPage> {
  // MainStoreProvider store = MainStoreProvider();

  @override
  Widget build(BuildContext context) {
    // var count = Provider.of<MainStoreProvider>(context).count;
    print('second page build');

    return Container(
      child: Text("seccond page fixedcount 3"),
    );
  }
}
