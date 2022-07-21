import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getxdemo/models/cart.dart';
import 'package:getxdemo/models/catalog.dart';
import 'package:getxdemo/pages/animation/animation.dart';
import 'package:getxdemo/pages/animation/animation_controller.dart';
import 'package:getxdemo/pages/custom_painter/custom_painter_demo.dart';
import 'package:getxdemo/pages/share_data/inherited_widget_test_demo.dart';
import 'package:getxdemo/pages/stack/stack_positioned_demo.dart';
import 'package:getxdemo/pages/easyloading/easyloading_demo.dart';
import 'package:getxdemo/pages/easyloading/easyloading_page1.dart';
import 'package:getxdemo/route/route.dart';
import 'package:getxdemo/sencond.dart';
import 'package:getxdemo/store/main_store.dart';
import 'package:getxdemo/third.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

import 'extend_wrap/extend_wrap_demo.dart';
import 'pages/custom_painters/custom_painter_demo.dart';
import 'pages/graphql_example/graphql_example_page.dart';
import 'pages/inherited_notifier/inherited_notifier_demo.dart';
import 'pages/inherited_notifier/inherited_notifier_second_page.dart';
import 'pages/inherited_notifier/slider_info.dart';
import 'pages/readmore/readmore_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late final HttpLink httpLink = HttpLink(
      // 'http://api.github.com/graphql',
      'http://localhost:4000/',
    );

    // late final AuthLink authLink = AuthLink(
    // getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // );

    // late final Link link = authLink.concat(httpLink);
    late final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(
          store: HiveStore(),
        ),
      ),
    );
    // Using MultiProvider is convenient when providing multiple objects.
    return GraphQLProvider(
      client: client,
      child: MultiProvider(
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

              highlightColor: Colors.transparent,
              brightness: Brightness.light,
              primarySwatch: Colors.purple,
            ),
            defaultTransition: Transition.native,
            translations: MyTranslations(),
            locale: const Locale('en'),
            //home: const MyHomePage(title: 'Flutter Demo Home Page'),
            builder: EasyLoading.init(),
          ),
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

  SliderInfo sliderInfo = SliderInfo();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: store,
      child: Scaffold(
        appBar: AppBar(
          title: Text("title".trArgs(['John'])),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<MainStoreProvider>(
                builder: (context, value, child) {
                  return Text(
                    '===${value.count}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const GraphqlExamplePage()),
                child: const Text('GraphqlExamplePage'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(
                    () => InheritedNotifierSecondPage(sliderInfo: sliderInfo)),
                child: const Text('InheritedNotifierSecondPage'),
              ),
              ElevatedButton(
                child: Text('button_text'.tr),
                onPressed: () {
                  var languageCode = Get.locale!.languageCode;
                  if (languageCode == 'zh') {
                    Get.updateLocale(const Locale('en'));
                  } else {
                    Get.updateLocale(const Locale('zh'));
                  }
                },
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const ReadmoreDemoPage()),
                child: const Text('ReadmoreDemoPage'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const InheritedWidgetTestDemo()),
                child: const Text('InheritedWidgetTestDemo'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const CustomPainterDemo()),
                child: const Text('CustomPainterDemo'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Get.to(() => const ExtendWrapPage(title: 'ExtendWrapPage')),
                child: const Text('ExtendWrapPage'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const CustomPaintExample()),
                child: const Text('CustomPaintExample'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const StackPositionedDemo()),
                child: const Text('StackPositionedDemo'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const EasyLoadingDemo()),
                child: const Text('easyloading'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const EasyLoadingPage1()),
                child: const Text('easyloadingpage1'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const AnimationControllerDemo()),
                child: const Text('AnimationControllerDemo'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const AnimationDemoPage()),
                child: const Text('AnimotionDemoPage'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('RefreshIndicatorDemo'),
                child: const Text('RefreshIndicatorDemo'),
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
                onPressed: () => Get.toNamed('SliverIndexedStackDemo'),
                child: const Text('SliverIndexedStackDemo'),
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
              const SecondPage(),
              const ThirdPage(),
              Container(
                child: RichText(
                  maxLines: 2,
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: const Chip(
                          label: Text('123123'),
                        ),
                      )
                    ],
                  ),
                ),
              )
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
