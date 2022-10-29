import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getxdemo/models/cart.dart';
import 'package:getxdemo/models/catalog.dart';
import 'package:getxdemo/pages/animation/animation.dart';
import 'package:getxdemo/pages/animation/animation_controller.dart';
import 'package:getxdemo/pages/stack/stack_positioned_demo.dart';
import 'package:getxdemo/pages/easyloading/easyloading_demo.dart';
import 'package:getxdemo/pages/easyloading/easyloading_page1.dart';
import 'package:getxdemo/pages/web_socket/web_socket_demo.dart';
import 'package:getxdemo/route/route.dart';
import 'package:getxdemo/store/main_store.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

import 'extend_wrap/extend_wrap_demo.dart';
import 'pages/custom_painters/custom_painter_demo.dart';
import 'pages/emoji/emoji_demo.dart';
import 'pages/fijkplayer/home_page.dart';
import 'pages/graphql_example/graphql_example_page.dart';
import 'pages/inherited_notifier/inherited_notifier_second_page.dart';
import 'pages/inherited_notifier/slider_info.dart';
import 'pages/readmore/readmore_demo.dart';
import 'pages/shimmer/shimmer_demo.dart';
import 'pages/show_modal_bottom/show_modal_bottom_demo.dart';
import 'pages/socket/socket_demo.dart';
import 'pages/youtube_player/youtube_player_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final HttpLink httpLink = HttpLink(
      'http://localhost:4000/',
    );
    late final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(
          store: HiveStore(),
        ),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: MultiProvider(
        providers: [
          Provider(create: (context) => CatalogModel()),
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
              highlightColor: Colors.transparent,
              brightness: Brightness.light,
              primarySwatch: Colors.purple,
            ),
            defaultTransition: Transition.native,
            translations: MyTranslations(),
            locale: const Locale('en'),
            builder: EasyLoading.init(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainStoreProvider store = MainStoreProvider();

  SliderInfo sliderInfo = SliderInfo();

  List<Widget> buttons = [];

  @override
  void initState() {
    super.initState();
  }

  // requestPremissions() async {
  //   NotificationSettings settings =
  //       await FirebaseMessaging.instance.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //     addListeners();
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  // addListeners() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');

  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('A new onMessageOpenedApp event was published!');
  //   });
  // }

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
                  var languageCode = Get.locale!.languageCode;
                  if (languageCode == 'zh') {
                    Get.updateLocale(Locale('en'));
                  } else {
                    Get.updateLocale(Locale('zh'));
                  }
                },
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
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Chip(
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
