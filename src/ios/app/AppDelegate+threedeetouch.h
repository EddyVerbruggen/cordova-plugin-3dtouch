#import "AppDelegate.h"

@interface AppDelegate (threedeetouch)
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler;

@end