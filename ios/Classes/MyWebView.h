//
//  LiveWKWebView.h
//  if_live_interactive
//
//  Created by voicewitness on 2021/8/25.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyWebView : WKWebView

@property (nonatomic, strong) NSDictionary* jsData;
@property (nonatomic, assign) CGFloat modalThreshold;

@end

NS_ASSUME_NONNULL_END
