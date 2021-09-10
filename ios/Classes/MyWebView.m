//
//  LiveWKWebView.m
//  if_live_interactive
//
//  Created by voicewitness on 2021/8/25.
//

#import "MyWebView.h"
#import <sys/utsname.h>

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)



@interface MyWebView ()

@property (nonatomic, assign) BOOL useViewAlphaCheck;

@end


@implementation MyWebView

- (BOOL)shouldRespondTouch:(UITouch *)touch {
    return [self pointInside:[touch locationInView:self] withEvent:nil];
}

- (id)init
{
    NSLog(@"LiveWKWebView %s", __FUNCTION__);
    self = [super init];
    [self commonSetup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"LiveWKWebView %s", __FUNCTION__);
    self = [super initWithFrame:frame];
    [self commonSetup];
    return self;
}

- (void)onTap {

}

- (void) commonSetup {
    self.modalThreshold = .6;
    self.useViewAlphaCheck = YES;
}

- (void)dealloc
{
    NSLog(@"LiveWKWebView %s", __FUNCTION__);
}

- (void)setModalThreshold:(CGFloat)modalThreshold
{
    _modalThreshold = MIN(MAX(modalThreshold, 0.0f), 1.0f);
}
- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
    NSLog(@"FFFFFF web %s", __FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
    NSLog(@"FFFFFF web %s", __FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
    NSLog(@"FFFFFF web %s", __FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    NSLog(@"FFFFFF web %s", __FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];

    NSLog(@"FFFFFFview is: %@", [view description]?:@"");
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    __weak typeof(self) weakSelf = self;
    CGFloat alpha = [self alphaOfPoint:point renderCommands:^(CGContextRef cgCtx, CGRect rect) {
        UIGraphicsPushContext(cgCtx);
        CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, weakSelf.bounds.size.height);
        CGContextConcatCTM(cgCtx, flipVertical);
        CGContextTranslateCTM(cgCtx, -point.x, (weakSelf.bounds.size.height - point.y));
        [weakSelf drawViewHierarchyInRect:weakSelf.bounds afterScreenUpdates:NO];
        UIGraphicsPopContext();
    }];
    BOOL pointInside = (alpha >= (1.0 - _modalThreshold));
    return pointInside;
}

- (CGFloat)alphaOfPoint:(CGPoint)point renderCommands:(void(^)(CGContextRef cgCtx, CGRect rect))cmd {
    CGFloat alpha = 0;
    CGContextRef cgCtx = [self createBitmapContextOf1pt];
    if (cgCtx) {
        CGRect rect = CGRectMake(point.x, point.y, point.x + 1, point.y + 1);
        cmd(cgCtx, rect);
        uint8_t *pixels = CGBitmapContextGetData(cgCtx);
        alpha = pixels[3]/255.0;
        CGContextRelease(cgCtx);
    }

    return alpha;
}

- (CGContextRef)createBitmapContextOf1pt {
    return [self createBitmapContextOfSize:CGSizeMake(1, 1)];
}

- (CGContextRef)createBitmapContextOfSize:(CGSize) size {
   CGContextRef    context = NULL;
   CGColorSpaceRef colorSpace;
   int             bitmapByteCount;
   int             bitmapBytesPerRow;

   bitmapBytesPerRow   = (size.width * 4);
   bitmapByteCount     = (bitmapBytesPerRow * size.height);
   colorSpace = CGColorSpaceCreateDeviceRGB();

   context = CGBitmapContextCreate (NULL,
                                    size.width,
                                    size.height,
                                    8,      // bits per component
                                    bitmapBytesPerRow,
                                    colorSpace,
                                    kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);

   CGContextSetAllowsAntialiasing(context, NO);
   if (context== NULL) {
       return NULL;
   }
   CGColorSpaceRelease( colorSpace );
   return context;
}

@end
