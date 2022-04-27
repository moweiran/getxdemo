import 'package:flutter/material.dart';

class StackPositionedDemo extends StatefulWidget {
  const StackPositionedDemo({Key? key}) : super(key: key);

  @override
  State<StackPositionedDemo> createState() => _StackPositionedDemoState();
}

class _StackPositionedDemoState extends State<StackPositionedDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StackPositionedDemo'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.only(bottom: 70),
              height: 240,
              color: Colors.blue[100],
              child: Row(
                children: [
                  // Expanded(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       color: Colors.blue[200],
                  //     ),
                  //     child: Stack(
                  //       alignment: AlignmentDirectional.topStart,
                  //       fit: StackFit.expand,
                  //       children: [
                  //         SizedBox(
                  //           width: double.infinity,
                  //           height: double.infinity,
                  //           child: Container(
                  //               // color: Colors.blue[600],
                  //               ),
                  //         ),
                  //         Align(
                  //           alignment: Alignment.topLeft,
                  //           child: Row(
                  //             children: [
                  //               Container(
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(100),
                  //                   color: const Color(0x4D000000),
                  //                 ),
                  //                 padding:
                  //                     const EdgeInsets.fromLTRB(10, 4, 4, 4),
                  //                 margin: const EdgeInsets.only(
                  //                   top: 4,
                  //                   left: 4,
                  //                 ),
                  //                 height: 30,
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.start,
                  //                   children: [
                  //                     Container(
                  //                       constraints: const BoxConstraints(
                  //                         maxWidth: 100,
                  //                       ),
                  //                       child: const Text(
                  //                         '3322323a',
                  //                         style: TextStyle(
                  //                           color: Colors.white,
                  //                           overflow: TextOverflow.ellipsis,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(
                  //                       width: 4,
                  //                     ),
                  //                     Container(
                  //                       width: 27,
                  //                       height: 22,
                  //                       alignment: Alignment.center,
                  //                       decoration: BoxDecoration(
                  //                         color: const Color(0XFF701AC6),
                  //                         borderRadius:
                  //                             BorderRadius.circular(12),
                  //                       ),
                  //                       child: const Text(
                  //                         '+',
                  //                         style: TextStyle(
                  //                           color: Colors.white,
                  //                           // fontSize: 20,
                  //                           fontWeight: FontWeight.w500,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               const Expanded(
                  //                 child: SizedBox(
                  //                   width: double.infinity,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 15,
                  // ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // color: Colors.blue[300],
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF25004A),
                            Color(0xFF4E0539),
                            Color(0xFF440031),
                          ],
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        fit: StackFit.expand,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Container(
                                // color: Colors.blue[600],
                                ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0x4D000000),
                                  ),
                                  //background: linear-gradient(180deg, #25004A 0%, #4E0539 51.56%, #440031 100%);

                                  padding:
                                      const EdgeInsets.fromLTRB(10, 4, 4, 4),
                                  margin: const EdgeInsets.only(
                                    top: 4,
                                    left: 4,
                                  ),
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 100,
                                        ),
                                        child: const Text(
                                          'd333333322323a',
                                          style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 27,
                                        height: 22,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0XFF701AC6),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          '+',
                                          style: TextStyle(
                                            color: Colors.white,
                                            // fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  color: Colors.blue[700],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'Connecting...',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
