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
       if ([str isEqualToString:@"Compose"])  return UIApplicationShortcutIconTypeCompose;
  else if ([str isEqualToString:@"Play"])     return UIApplicationShortcutIconTypePlay;
  else if ([str isEqualToString:@"Pause"])    return UIApplicationShortcutIconTypePause;
  else if ([str isEqualToString:@"Add"])      return UIApplicationShortcutIconTypeAdd;
  else if ([str isEqualToString:@"Location"]) return UIApplicationShortcutIconTypeLocation;
  else if ([str isEqualToString:@"Search"])   return UIApplicationShortcutIconTypeSearch;
  else if ([str isEqualToString:@"Share"])    return UIApplicationShortcutIconTypeShare;
  else if ([str isEqualToString:@"Prohibit"]) return UIApplicationShortcutIconTypeProhibit;
  else if ([str isEqualToString:@"Contact"])  return UIApplicationShortcutIconTypeContact;
  else if ([str isEqualToString:@"Home"])     return UIApplicationShortcutIconTypeHome;
  else if ([str isEqualToString:@"MarkLocation"])    return UIApplicationShortcutIconTypeMarkLocation;
  else if ([str isEqualToString:@"Favorite"]) return UIApplicationShortcutIconTypeFavorite;
  else if ([str isEqualToString:@"Love"])     return UIApplicationShortcutIconTypeLove;
  else if ([str isEqualToString:@"Cloud"])    return UIApplicationShortcutIconTypeCloud;
  else if ([str isEqualToString:@"Invitation"])      return UIApplicationShortcutIconTypeInvitation;
  else if ([str isEqualToString:@"Confirmation"])    return UIApplicationShortcutIconTypeConfirmation;
  else if ([str isEqualToString:@"Mail"])     return UIApplicationShortcutIconTypeMail;
  else if ([str isEqualToString:@"Message"])  return UIApplicationShortcutIconTypeMessage;
  else if ([str isEqualToString:@"Date"])     return UIApplicationShortcutIconTypeDate;
  else if ([str isEqualToString:@"Time"])     return UIApplicationShortcutIconTypeTime;
  else if ([str isEqualToString:@"CapturePhoto"])    return UIApplicationShortcutIconTypeCapturePhoto;
  else if ([str isEqualToString:@"CaptureVideo"])    return UIApplicationShortcutIconTypeCaptureVideo;
  else if ([str isEqualToString:@"Task"])     return UIApplicationShortcutIconTypeTask;
  else if ([str isEqualToString:@"TaskCompleted"])   return UIApplicationShortcutIconTypeTaskCompleted;
  else if ([str isEqualToString:@"Alarm"])    return UIApplicationShortcutIconTypeAlarm;
  else if ([str isEqualToString:@"Bookmark"]) return UIApplicationShortcutIconTypeBookmark;
  else if ([str isEqualToString:@"Shuffle"])  return UIApplicationShortcutIconTypeShuffle;
  else if ([str isEqualToString:@"Audio"])    return UIApplicationShortcutIconTypeAudio;
  else if ([str isEqualToString:@"Update"])   return UIApplicationShortcutIconTypeUpdate;
  else {
    NSLog(@"Invalid iconType passed to the 3D Touch plugin.");
    return 0;
  }
}
@end
