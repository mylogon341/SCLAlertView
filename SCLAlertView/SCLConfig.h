//
//  SCLConfig.h
//  SCLAlertView
//
//  Created by Luke Sadler on 09/05/2016.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCLConfig : NSObject  <NSObject>


+(_Nonnull instancetype)configWithColour:(nullable UIColor*)colour background:(nonnull UIColor*)background andFont:(nullable UIFont*)font;

/**HEX to be inputted like #3D8FBA, with or without # */
+(_Nonnull instancetype)configWithHEX:(nonnull NSString*)colour backgroundHEX:(nonnull NSString*)background andFont:(nonnull UIFont *)font;


/**
 * Sets the global colour of all alerts. Defaults to light gray (buttons and spinner if loading)
 */
@property (nonatomic, strong, nullable) UIColor * corperateColour;

/**
 * Sets the global colour of all alerts. Defaults to light white
 */
@property (nonatomic, strong, nullable) UIColor * background;

/**
 * Sets the global font of all alerts. Defaults to Avenir 18
 */
@property (nonatomic, strong, nullable) UIFont * globalFont;


@end
