#import "AppDelegate+threedeetouch.h"
#import "ThreeDeeTouch.h"
#import <objc/runtime.h>
#import "MainViewController.h"

@implementation AppDelegate (threedeetouch)

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {

  NSString* jsFunction = @"ThreeDeeTouch.onHomeIconPressed";
  NSString *params = [NSString stringWithFormat:@"{'type':'%@', 'title': '%@'}", shortcutItem.type, shortcutItem.localizedTitle];
  NSString* result = [NSString stringWithFormat:@"%@(%@)", jsFunction, params];
  [self callJavascriptFunctionWhenAvailable:result];
}

// check every x seconds for the phone  app to be ready, or stop from glance.didDeactivate
- (void) callJavascriptFunctionWhenAvailable:(NSString*)function {
  ThreeDeeTouch *threeDeeTouch = [self.viewController getCommandInstance:@"ThreeDeeTouch"];
  if (threeDeeTouch.initDone) {
    if ([threeDeeTouch.webView respondsToSelector:@selector(stringByEvaluatingJavaScriptFromString:)]) {
      // UIWebView
      [threeDeeTouch.webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:function waitUntilDone:NO];
    } else if ([threeDeeTouch.webView respondsToSelector:@selector(evaluateJavaScript:completionHandler:)]) {
      // WKWebView
      [threeDeeTouch.webView performSelector:@selector(evaluateJavaScript:completionHandler:) withObject:function withObject:nil];
    } else {
      NSLog(@"No compatible method found to communicate 3D Touch callback to the webview. Please notify the plugin author.");
    }
  } else {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 25 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
      [self callJavascriptFunctionWhenAvailable:function];
    });
  }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

@end