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


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
    if ([hexString characterAtIndex:0] == '#') {
        [scanner setScanLocation:1]; // bypass '#' character
    }
    
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(instancetype)configurationWithBlock:(void (^)(id<SCLMutableConfig>))configurationBlock{
    return [[self alloc]initWithBlock:configurationBlock];
}

- (instancetype)initWithBlock:(void (^)(SCLConfig *))configurationBlock {
    self = [self initEmpty];
    if (!self) return nil;
    
    configurationBlock(self);
    
    return self;
}

- (instancetype)initEmpty {
    self = [super init];
    if (!self) return nil;
    
//    _networkRetryAttempts = PFCommandRunningDefaultMaxAttemptsCount;
//    _server = [_ParseDefaultServerURLString copy];
    
    return self;
}

@end
