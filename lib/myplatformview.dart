import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

const String myViewType = "mywebview";

// class LiveInteractiveController {
//   Function(String eventName, Map eventData) doPostNotification;
//   Function renderSuccess;

//   IFLiveWVRegistry wvRegistry;

//   LiveInteractiveController(MethodChannel channel) {
//     wvRegistry = IFLiveWVRegistry(channel);
//   }
// }

class MyPlatformView extends StatefulWidget {
  Map query;
  MyPlatformView({this.query});

  @override
  _MyPlatformViewState createState() => _MyPlatformViewState();
}

class _MyPlatformViewState extends State<MyPlatformView> {
  /// 平台通道,消息使用平台通道在客户端（UI）和宿主（平台）之间传递
  MethodChannel _channel;

  void Function(String eventName, Map eventData) callPostNotification;

  // LiveInteractiveController interactiveController;

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      // 视图类型，作为唯一标识符
      viewType: myViewType,
      hitTestBehavior: PlatformViewHitTestBehavior.transparent,
      // 创建参数：将会传递给 iOS 端侧, 可以传递任意类型参数
      creationParams: widget.query,
      // 用于将creationParams编码后再发送到平台端。
      // 这里使用Flutter标准二进制编码
      creationParamsCodec: StandardMessageCodec(),
      // 原生视图创建回调
      onPlatformViewCreated: _onPlatformViewCreated,
    );
  }

  /// 原生视图创建回调操作
  /// id 是原生视图唯一标识符
  void _onPlatformViewCreated(int id) {}

  /// 平台通道的响应函数
  Future<void> _handleMethod(MethodCall call) async {
    /// 视图没被装载的情况不响应操作
    if (!mounted) {
      return Future.value();
    }
    switch (call.method) {
      default:
        throw UnsupportedError("Unrecognized method");
    }
  }

  @override
  void dispose() {
    // _channel.invokeMethod("dispose");
    super.dispose();
  }
}
