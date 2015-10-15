#import <Cordova/CDVPlugin.h>

@interface ThreeDeeTouch : CDVPlugin

@property BOOL initDone;

- (void) deviceIsReady:(CDVInvokedUrlCommand*)command;

- (void) isAvailable:(CDVInvokedUrlCommand*)command;

- (void) configureQuickActions:(CDVInvokedUrlCommand*)command;

- (void) enableLinkPreview:(CDVInvokedUrlCommand*)command;
- (void) disableLinkPreview:(CDVInvokedUrlCommand*)command;

@end
