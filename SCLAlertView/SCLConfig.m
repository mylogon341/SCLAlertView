//
//  SCLConfig.m
//  SCLAlertView
//
//  Created by Luke Sadler on 09/05/2016.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

#import "SCLConfig.h"
#import "SCLMacros.h"

@implementation SCLConfig

+(_Nonnull instancetype)configWithColour:(nullable UIColor*)colour background:(nonnull UIColor*)background andFont:(nullable UIFont*)font{
    SCLConfig * config = [[self alloc]init];
    config.corperateColour = colour;
    config.globalFont = font;
    
    return config;
}

+(instancetype)configWithHEX:(NSString*)colour backgroundHEX:(NSString*)background andFont:(UIFont *)font{
    return [SCLConfig configWithColour:[self colorFromHexString:colour] background:[self colorFromHexString:background] andFont:font];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
    if ([hexString characterAtIndex:0] == '#') {
        [scanner setScanLocation:1]; // bypass '#' character
    }
    
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
