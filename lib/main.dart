import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/TargetWidget.dart';
import 'package:getxdemo/example.dart';
import 'package:getxdemo/fourth.dart';
import 'package:getxdemo/models/cart.dart';
import 'package:getxdemo/models/catalog.dart';
import 'package:getxdemo/pages/swiper_demo.dart';
import 'package:getxdemo/route/route.dart';
import 'package:getxdemo/screens/cart.dart';
import 'package:getxdemo/screens/catalog.dart';
import 'package:getxdemo/screens/easyrefhres_demo.dart';
import 'package:getxdemo/screens/easyrefresh.dart';
import 'package:getxdemo/screens/overlay_page.dart';
import 'package:getxdemo/sencond.dart';
import 'package:getxdemo/store/main_store.dart';
import 'package:getxdemo/third.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: OverlaySupport.global(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/home',
          getPages: DemoRoute.routes,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          defaultTransition: Transition.native,
          translations: MyTranslations(),
          locale: const Locale('en'),
          //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainStoreProvider store = MainStoreProvider();

  @override
  Widget build(BuildContext context) {
    print('main build=====');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ChangeNotifierProvider.value(
      value: store,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("title".trArgs(['John'])),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Consumer<MainStoreProvider>(
                builder: (context, value, child) {
                  print('main consumer build');
                  return Text(
                    '===${value.count}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              ElevatedButton(
                child: Text('button_text'.tr),
                onPressed: () {
                  print(Get.locale);
                  print(Get.deviceLocale);
                  print(Get.locale!.languageCode);
                  print(Get.fallbackLocale);
                  var languageCode = Get.locale!.languageCode;
                  if (languageCode == 'zh') {
                    Get.updateLocale(Locale('en'));
                  } else {
                    Get.updateLocale(Locale('zh'));
                  }
                },
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('extend_nestedscrollview'),
                child: const Text('PullToRefreshOuterDemo'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('load_more'),
                child: const Text('load_more'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('pull_refresh_load_more'),
                child: const Text('pull_refresh_load_more'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('NestedScrollViewDemo'),
                child: const Text('NestedScrollViewDemo'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('second'),
                child: const Text('goto SecondPage'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('fourth'),
                child: const Text('goto fourth'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('overlay'),
                child: const Text('goto overlay'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('OverLayPage'),
                child: const Text('goto overlay2'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('target'),
                child: const Text('goto target'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('easyrefersh_demo'),
                child: const Text('goto easyrefresh demo'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('lzystackdemo');
                },
                child: const Text('lzystackdemo'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('catalog'),
                child: const Text('goto catalog'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('easyrefersh'),
                child: const Text('goto easyrefersh'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('ExampleHorizontal'),
                child: const Text('goto ExampleHorizontal'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('indexedstack_demo'),
                child: const Text('indexedstack_demo'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('PageViewDemo'),
                child: const Text('PageViewDemo'),
              ),
              ElevatedButton(
                onPressed: () {
                  // popup a toast.
                  // toast('Hello world!');

                  // // show a notification at top of screen.
                  // showSimpleNotification(
                  //     Text("this is a message from simple notification"),
                  //     background: Colors.green);

                  // We create the tooltip on the first use
                  var tooltip = SuperTooltip(
                    popupDirection: TooltipDirection.down,
                    content: const Material(
                        child: Text(
                      "Lorem ipsum dolor sit amet, consetetur sadipscingelitr, "
                      "sed diam nonumy eirmod tempor invidunt ut laboreet dolore magna aliquyam erat, "
                      "sed diam voluptua. At vero eos et accusam et justoduo dolores et ea rebum. ",
                      softWrap: true,
                    )),
                  );

                  tooltip.show(context);
                },
                child: const Text('tooltip'),
              ),
              SecondPage(),
              ThirdPage(),
            ],
          ),
        ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(
        //       onPressed: () {
        //         store.incrementCounter();
        //       },
        //       tooltip: 'button_text'.tr,
        //       child: const Icon(Icons.add),
        //     ),
        //     FloatingActionButton(
        //       onPressed: () {
        //         store.incrementSecondCounter();
        //       },
        //       tooltip: 'button_text'.tr,
        //       child: const Icon(Icons.add),
        //     )
        //   ],
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'title': 'Hello World %s',
          'button_text': 'change language',
          'button2': 'button2',
        },
        'zh': {
          'title': '你好 %s',
          'button_text': '切换',
          'button2': '按钮2',
        },
      };
}
