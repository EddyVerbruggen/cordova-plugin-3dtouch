#import "Cordova/CDV.h"
#import "Cordova/CDVViewController.h"
#import "UIKit/UITouch.h"
#import "ThreeDeeTouch.h"

@implementation ThreeDeeTouch

- (void) deviceIsReady:(CDVInvokedUrlCommand *)command {
  self.initDone = YES;
}

- (void) isAvailable:(CDVInvokedUrlCommand *)command {

  bool avail = NO;

  if (IsAtLeastiOSVersion(@"9")) {
    avail = [self.viewController.traitCollection forceTouchCapability] == UIForceTouchCapabilityAvailable;
  }

  CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:avail];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) enableLinkPreview:(CDVInvokedUrlCommand *)command {
  self.webView.allowsLinkPreview = YES;
  [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void) disableLinkPreview:(CDVInvokedUrlCommand *)command {
  self.webView.allowsLinkPreview = NO;
  [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void) configureQuickActions:(CDVInvokedUrlCommand *)command {
  NSDictionary *actions = [command.arguments objectAtIndex:0];
  
  NSMutableArray *items = [[NSMutableArray alloc] init];

  for (NSDictionary *action in actions) {
    NSString *type = [action objectForKey:@"type"];
    NSString *title = [action objectForKey:@"title"];
    NSString *subtitle = [action objectForKey:@"subtitle"];
    NSString *iconType = [action objectForKey:@"iconType"];
    NSString *iconTemplate = [action objectForKey:@"iconTemplate"];

    UIApplicationShortcutIcon *icon = nil;
    if (iconType != nil) {
      icon = [UIApplicationShortcutIcon iconWithType:[self UIApplicationShortcutIconTypeFromString:iconType]];
    } else if (iconTemplate != nil) {
      icon = [UIApplicationShortcutIcon iconWithTemplateImageName:iconTemplate];
    }

    [items addObject:[[UIApplicationShortcutItem alloc]initWithType: type localizedTitle: title localizedSubtitle: subtitle icon: icon userInfo: nil]];
  }

  [UIApplication sharedApplication].shortcutItems = items;
  [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (UIApplicationShortcutIconType) UIApplicationShortcutIconTypeFromString:(NSString*)str {
       if ([str isEqualToString:@"compose"])  return UIApplicationShortcutIconTypeCompose;
  else if ([str isEqualToString:@"play"])     return UIApplicationShortcutIconTypePlay;
  else if ([str isEqualToString:@"pause"])    return UIApplicationShortcutIconTypePause;
  else if ([str isEqualToString:@"add"])      return UIApplicationShortcutIconTypeAdd;
  else if ([str isEqualToString:@"location"]) return UIApplicationShortcutIconTypeLocation;
  else if ([str isEqualToString:@"search"])   return UIApplicationShortcutIconTypeSearch;
  else if ([str isEqualToString:@"share"])    return UIApplicationShortcutIconTypeShare;
  else {
    NSLog(@"Invalid iconType passed to the 3D Touch plugin.");
    return 0;
  }
}
@end
