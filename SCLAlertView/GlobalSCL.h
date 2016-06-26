//
//  A nice helper class that should hopefully take the shit out of creating alerts for apps.
//
//

#import <Foundation/Foundation.h>
#import "SCLAlertView.h"
#import "SCLConfig.h"

@interface GlobalSCL : NSObject


+(SCLAlertView *)sclGlobalWithNewWindow:(BOOL)newWindow;

+ (UIViewController*) topMostController;

/**OPTIONAL:
 *A good idea to pass this in app delegate (didFinishLaunchingWithOptions) or somewhere similar to make sure default vaules are always set
 */
+(void)alertConfig:(SCLConfig*)config;

/** Body can be nil and title will be larger. Vice versa. Title is char limited*/
+(void)sclWaitingShow:(NSString *)title body:(NSString*)body;

/**Call this in success handlers to kill off the current 'Waiting' view. Will automaticall call on main thread*/
+(void)sclWaitingHide;

/**Shows a message for set number of seconds. Useful for success messages etc*/
+(void)showMessage:(NSString *)message forSeconds:(NSUInteger)seconds;

/**Shows a message for set number of seconds with title.*/
+(void)showMessage:(NSString *)title withBody:(NSString*)body forSeconds:(NSUInteger)seconds;

/**Update alert string here. Useful for progress text etc*/
+(void)updateAlertText:(NSString*)body;


/**Getter for font, set in config file. If not set in an SCLConfig for alertConfig:, then will fall back on Avenir 18*/
+(UIFont*)getGlobalFont;

/**Getter for colour set in config file. If not set in an SCLConfig for alertConfig:, then will fall back on lightGray*/
+(UIColor*)getGlobalColour;

+(UIColor*)getBackgroundColour;

+(BOOL)areAllTitlesUppercase;

@end


