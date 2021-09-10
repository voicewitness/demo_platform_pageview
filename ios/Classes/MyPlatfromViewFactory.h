#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPlatfromViewFactory : NSObject<FlutterPlatformViewFactory>

/// 初始化视图工厂
/// @param messager 用于与 Flutter 传输二进制消息通信
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager;

@end

NS_ASSUME_NONNULL_END
