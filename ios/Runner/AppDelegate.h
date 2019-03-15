#import <Flutter/Flutter.h>

#import <UIKit/UIKit.h>
#import "BeeCloud.h"
@interface AppDelegate : FlutterAppDelegate<BeeCloudDelegate>

- (void)paymentAchive:(NSNotification*)notification;
@end
