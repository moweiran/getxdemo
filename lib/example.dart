import 'package:flutter/material.dart';

class Example1 extends StatefulWidget {
  const Example1({Key? key}) : super(key: key);

  @override
  _Example1State createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  void _showOverlay(BuildContext context) async {
    // Declaring and Initializing OverlayState
    // and OverlayEntry objects
    OverlayState overlayState = Overlay.of(context)!;
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      // You can return any widget you like here
      // to be displayed on the Overlay
      return Positioned(
        left: MediaQuery.of(context).size.width * 0.2,
        top: MediaQuery.of(context).size.height * 0.3,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            children: [
              // Image.asset(
              //   'images/commentCloud.png',
              //   colorBlendMode: BlendMode.multiply,
              // ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.13,
                left: MediaQuery.of(context).size.width * 0.13,
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        'This is a button!',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    GestureDetector(
                      onTap: () {
                        // When the icon is pressed the OverlayEntry
                        // is removed from Overlay
                        overlayEntry.remove();
                      },
                      child: Icon(Icons.close,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.height * 0.025),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GeeksForGeeks Example 2',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Center(
              child: MaterialButton(
        color: Colors.green,
        minWidth: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Text(
          'show Overlay',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          // calling the _showOverlay method
          // when Button is pressed
          _showOverlay(context);
        },
      ))),
    );
  }
}
