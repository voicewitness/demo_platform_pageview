import 'package:flutter/material.dart';
import 'package:hello/myplatformview.dart';

class MyCell extends StatefulWidget {
  int index;
  MyCell({Key key, this.index}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyCellState();
}

class _MyCellState extends State<MyCell> {
  PageController _overlayerController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.red,
              child: Center(
                  child: Text("fake player here",
                      style: TextStyle(color: Colors.black, fontSize: 25)))),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  color: Colors.transparent,
                  child: MyPlatformView(query: {
                    "data": {
                      "activityPosition":
                          "0-0-${MediaQuery.of(context).size.width}-${MediaQuery.of(context).size.height}"
                    }
                  })
                  // child: PageView.builder(
                  //     controller: _overlayerController,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       if (index == 0) {
                  //         return Stack(children: [
                  //           SafeArea(
                  //               top: true,
                  //               child: Container(
                  //                   width: MediaQuery.of(context).size.width,
                  //                   height: MediaQuery.of(context).size.height,
                  //                   child: Text(
                  //                     "leftScreen",
                  //                     style: TextStyle(
                  //                         color: Colors.black, fontSize: 20),
                  //                   )))
                  //         ]);
                  //       } else if (index == 1) {
                  //         return Container(
                  //             child: Stack(children: [
                  //           Positioned(
                  //               top: 40,
                  //               left: 15,
                  //               child: SafeArea(
                  //                   top: true,
                  //                   child: Container(
                  //                       child: Row(
                  //                     children: [
                  //                       Text(
                  //                         "aSimpleText${widget.index}",
                  //                         style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontSize: 20),
                  //                       )
                  //                     ],
                  //                   )))),
                  //           // MyPlatformView(query: {
                  //           //   "data": {
                  //           //     "activityPosition":
                  //           //         "0-0-${MediaQuery.of(context).size.width}-${MediaQuery.of(context).size.height}"
                  //           //   }
                  //           // })
                  //         ]));
                  //       } else if (index == 2) {
                  //         return Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             height: MediaQuery.of(context).size.height,
                  //             child: SafeArea(
                  //                 top: true,
                  //                 child: Text(
                  //                   "rightScreen",
                  //                   style: TextStyle(
                  //                       color: Colors.black, fontSize: 20),
                  //                 )));
                  //       }
                  //     },
                  //     itemCount: 3)
                  ))
        ]));
  }
}
