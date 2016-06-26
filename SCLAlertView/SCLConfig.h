//
//  SCLConfig.h
//  SCLAlertView
//
//  Created by Luke Sadler on 09/05/2016.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SCLMutableConfig <NSObject>


/**Sets the global colour of all alerts. Defaults to light gray (buttons and spinner if loading)*/
@property (nullable, nonatomic) UIColor * corperateColour;

/** Sets the global colour of all alerts. Defaults to light white*/
@property (nullable, nonatomic) UIColor * background;


/**Sets the global font of all alerts. Defaults to Avenir 18*/
@property (nullable, nonatomic) UIFont * globalFont;

/**Forces all titles to be uppercase globally*/
@property (nonatomic) BOOL titlesUpperCase;

@end


@interface SCLConfig : NSObject  <NSObject>


+(_Nonnull instancetype)configurationWithBlock:(void (^ _Nonnull)(_Nonnull id<SCLMutableConfig>))configurationBlock;

@property (nullable, nonatomic, copy) UIColor * corperateColour;

@property (nullable, nonatomic, copy) UIColor * background;

@property (nullable, nonatomic, copy) UIFont * globalFont;

@property (nonatomic, getter=areAllTitlesUppercase) BOOL titlesUpperCase;

@end
