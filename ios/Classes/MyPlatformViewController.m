#import "MyPlatformViewController.h"
#import "MyWebView.h"
//#import "LiveWeexView.h"

@interface MyPlatformViewController ()

/// 视图
@property (nonatomic, strong) UIView *yellowView;

 @property (nonatomic, strong) MyWebView *platformView;

/// 平台通道
@property (nonatomic, strong) FlutterMethodChannel *channel;

@end

@implementation MyPlatformViewController

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onRenderSuccuess:) name:@"InteractRenderSuccess" object:nil];

        /// 初始化视图
        if([args isKindOfClass:[NSDictionary class]]) {
            NSString *viewType = args[@"viewType"];
            if([viewType isKindOfClass:[NSString class]] && [viewType isEqualToString:@"weex"]) {

                NSDictionary *data = args[@"data"];
                NSString *url = args[@"url"];

                UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
                NSString *result = (UIInterfaceOrientationIsLandscape(orientation)) ? @"landscape" : @"portrait";
//                NSString *isIPhoneXSeries = [TaoLiveFoundation isIPhoneXSeries] ? @"true" : @"false";
                NSString *isIPhoneXSeries = @"false";
                CGFloat minSide = MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
                CGFloat height = 88 * 375.0f / minSide;
//                NSString *cutoutHeight = [TaoLiveFoundation isIPhoneXSeries] ? [NSString stringWithFormat:@"%lld", (long long)floor(height)] : @"0";
                NSString *cutoutHeight = @"0";


                NSArray *frameArray = [data[@"activityPosition"]componentsSeparatedByString:@"-"];
                CGRect frame = CGRectMake([frameArray[0]integerValue], [frameArray[1]integerValue], [frameArray[2]integerValue], [frameArray[3]integerValue]);
                NSMutableDictionary *weexParams = [NSMutableDictionary dictionaryWithDictionary:@{@"popupWindowUrl": url,
                                                                                                  @"renderType": data[@"renderType"]?:@"",
                                                                                                  @"direction": result,
                                                                                                  @"iPhoneX": isIPhoneXSeries,
                                                                                                  @"isDisplayCutout": isIPhoneXSeries,
                                                                                                  @"cutoutHeight": cutoutHeight}];
//                self.platformView = [self loadWeexWithFrame:frame params:weexParams];

            } else {
                NSString *url = args[@"url"];
                NSDictionary *data = args[@"data"];
                if (![url isKindOfClass:[NSString class]]) {
                    url = nil;
                }
                if (![data isKindOfClass:[NSDictionary class]]) {
                    data = nil;
                }
                self.platformView = [self loadWithUrl:url data:data];
            }
        }

        /// 这里的channelName是和Flutter 创建MethodChannel时的名字保持一致的，保证一个原生视图有一个平台通道传递消息
        NSString *channelName = [NSString stringWithFormat:@"mywebview_%lld", viewId];
        self.channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        // 处理 Flutter 发送的消息事件
//        __weak typeof(_platformView) weakpv = _platformView;
        __weak typeof(self) weakSelf = self;
        [self.channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
            if ([call.method isEqualToString:@"dispose"]) {
                // [_platformView liveRoomViewWillDisappear];
                // [_platformView liveRoomViewDidDisappear];
                // _platformView = nil;
            } else if([call.method isEqualToString:@"load"]) {
                //                NSDictionary *args = call.arguments;
                //                if ([args isKindOfClass:[NSDictionary class]]) {
                //                    NSString *url = args[@"url"];
                //                    NSDictionary *data = args[@"data"];
                //                    weakSelf.platformView = [weakSelf loadWithUrl:url data:data];
                //                }
                            }  else if([call.method isEqualToString:@"renderSuccess"]) {
                                self.platformView.hidden = NO;

                                            } else if([call.method isEqualToString:@"registerWVHandler"]) {
                                            } else if([call.method isEqualToString:@"postNotification"]) {
                                            }
        }];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - FlutterPlatformView
/// 返回真正的视图
- (UIView *)view {
     return _platformView;
}

- (MyWebView *)loadWithUrl:(NSString *)url data:(NSDictionary *)data  {

    NSArray *frameArray = [data[@"activityPosition"]componentsSeparatedByString:@"-"];
    CGRect frame = CGRectMake([frameArray[0]integerValue], [frameArray[1]integerValue], [frameArray[2]integerValue], [frameArray[3]integerValue]);

    MyWebView *webView = nil;
    webView = [[MyWebView alloc] initWithFrame:frame];



    UIScrollView *scrollView = (webView).scrollView;

    webView.backgroundColor = [UIColor clearColor];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.opaque = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.scrollEnabled = NO;
    scrollView.opaque = NO;
    scrollView.scrollEnabled = YES;
    scrollView.bounces = NO;

//    [(WVWKWebView *)webView enableWVMix];
//    webView.openLocalService = YES;
//    webView.windVaneDelegate = self;
//    webView.sourceViewController = vc;
    webView.hidden = NO;

//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    __block NSURL *path =nil;
    [[NSBundle allBundles]enumerateObjectsUsingBlock:^(NSBundle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSURL *p = [obj URLForResource:@"mytest.html" withExtension:nil];
            if(p) {
                path = p;
                *stop = YES;
            }
    }];
    NSURLRequest *request = [NSURLRequest requestWithURL:path];
    [webView loadRequest:request];
    return webView;

    /// 主要是埋点
//    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewLoader:didAddWebView:)]) {
//        [self.delegate webViewLoader:self didAddWebView:webView];
//    }

//    model.renderView = webView;

//    if (![model.rendType isEqualToString:TBLiveWebViewRendType_H5Container]) {
//        UIView *actionView = [self setupModalViewWithWebView:webView];
//        model.actionView = actionView;
//        [self addWebview:webView];
//    }
}

- (void)onRenderSuccuess:(NSNotification *)notification
{
    UIView *webView = notification.object[@"webView"];
    if ([webView isKindOfClass:[UIView class]]) {
        webView.hidden = NO;
    }
}

//- (LiveWeexView *)loadWeexWithFrame:(CGRect)frame params:(id)weexParams {
//
//    LiveWeexView *baseView = [[LiveWeexView alloc] initWithFrame:frame data:weexParams created:^(UIView *view) {
//        dispatch_async(dispatch_get_main_queue(), ^{
////            [weakSelf webViewDidCreated:view];
//        });
//
//    } success:^{
////        [weakSelf webViewRenderSuccess:[webViewModel bottomView]];
//    } loadFailed:^(NSError *error) {
////        [weakSelf loadFailedCallback:url error:error];
//    } jsRuntimeError:^(NSError *error) {
////        [weakSelf webViewJSRuntimeError:error];
//    } weexModuleName:@"TBLiveWeexInstanceModule"];
//    return baseView;
//}


@end
