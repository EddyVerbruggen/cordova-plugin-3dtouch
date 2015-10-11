#import <Cordova/CDVPlugin.h>

@interface ThreeDeeTouch : CDVPlugin

@property BOOL initDone;

- (void) isAvailable:(CDVInvokedUrlCommand*)command;

- (void) configureQuickActions:(CDVInvokedUrlCommand*)command;

- (void) enableLinkPreview:(CDVInvokedUrlCommand*)command;
- (void) disableLinkPreview:(CDVInvokedUrlCommand*)command;

@end
