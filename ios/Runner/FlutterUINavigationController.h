
#import <Flutter/Flutter.h>
@class UIViewController;
@interface FlutterUINavigationController
: UINavigationController <FlutterBinaryMessenger, FlutterTextureRegistry, FlutterPluginRegistry>

@end
