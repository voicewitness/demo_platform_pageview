import 'package:flutter/material.dart';
import 'package:hello_example/mycell.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<String> list = [];
  @override
  void initState() {
    super.initState();
    // initPlatformState();
    refreshAndPushOne();
    _switchCellToIndex(0);
    // Future.delayed(Duration(seconds: 1), () {

    // });
  }

  pushOne() {
    list.add(list.length.toString());
  }

  refreshAndPushOne() {
    pushOne();
    refresh();
  }

  refresh() {
    setState(() {});
  }

  pushCountThenRefresh(int count) {
    Future.delayed(Duration(milliseconds: 600), () {
      for (int i = 0; i < count; i++) {
        pushOne();
      }
      refresh();
    });
  }

  int currentIndex = 0;

  _switchCellToIndex(int index) {
    if (index == list.length - 1) {
      pushCountThenRefresh(5);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            itemCount: list.length,
            // controller: _immersivePageController,
            itemBuilder: (BuildContext context, int index) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: MyCell(index: index)),
            scrollDirection: Axis.vertical,
            onPageChanged: (int index) {
              _switchCellToIndex(index);
            },
          )),
    );
  }
}
