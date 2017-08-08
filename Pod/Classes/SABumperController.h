//
//  SABumperController.h
//  Pods
//
//  Created by Gabriel Coman on 07/08/2017.
//
//

#import <UIKit/UIKit.h>

//
// define bumper callback
typedef void (^sabumpercallback)();

//
// define the SABumperController class
@interface SABumperController : UIViewController

+ (void) playFromVC:(UIViewController*) parent;

+ (void) playFromVC:(UIViewController*) parent
 andOverrideAppName:(NSString*) name
 andOverrideAppLogo:(UIImage*) image;

+ (void) setCallback:(sabumpercallback)callback;

@end
