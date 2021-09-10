#import "HelloPlugin.h"
#import "MyPlatfromViewFactory.h"


@interface HelloPlugin()
@property(readonly, nonatomic) NSObject<FlutterTextureRegistry>     *registry;
@property(readonly, nonatomic) NSObject<FlutterBinaryMessenger>     *messenger;
@property(nonatomic, strong) FlutterMethodChannel* channel;
@end

@implementation HelloPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"hello_plugin"
              binaryMessenger:[registrar messenger]];
    HelloPlugin* instance = [[HelloPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    instance.channel = channel;

    [registrar registerViewFactory:[[MyPlatfromViewFactory alloc] initWithMessenger:[registrar messenger]]
                                withId:@"mywebview"];
}

- (instancetype)initWithRegistry:(NSObject<FlutterTextureRegistry>*)registry
                       messenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self = [super init];
    NSAssert(self, @"super init cannot be nil");
    _registry = registry;
    _messenger = messenger;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary *argsMap = call.arguments;
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if([@"cacheComponent" isEqualToString:call.method]) {
        NSDictionary *args = call.arguments;
    } else if ([@"registerWVHandler" isEqualToString:call.method]) {
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
