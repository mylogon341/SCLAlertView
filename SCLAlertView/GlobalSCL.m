//
//  GlobalSCL.m
//  SCLAlertView
//
//  Created by Luke Sadler on 09/05/2016.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

#import "GlobalSCL.h"

@interface GlobalSCL()

@property (nonatomic, strong) SCLAlertView *aAlert;
@property (nonatomic, strong) SCLConfig *configFile;;

@end

@implementation GlobalSCL

+(void)alertConfig:(SCLConfig *)config{
    [self globalSelf].configFile = config;
}

+(SCLAlertView *)sclGlobal{
    
    [self sclWaitingHide];
    
    SCLAlertView * alert = [[self globalSelf] alert];
    [alert removeTopCircle];
    return alert;
}

+(GlobalSCL*)globalSelf{
    static GlobalSCL * global;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[GlobalSCL alloc]init];
    });
    
    return global;
}

-(SCLAlertView*)alert{
    if (!_aAlert) {
        
        __weak typeof(self) weakSelf = self;

        _aAlert = [[SCLAlertView alloc]initWithNewWindow];
        [_aAlert setCustomViewColor: self.configFile.corperateColour ? self.configFile.corperateColour : [UIColor lightGrayColor]];
        _aAlert.attributedFormatBlock = ^NSAttributedString* (NSString *value)
        {
            return [weakSelf sclAttString:value];
        };
        
        [_aAlert setBackgroundType:Transparent];
        [_aAlert setShowAnimationType:FadeIn];
        [_aAlert setHideAnimationType:FadeOut];
        
    }
    return _aAlert;
}

+(void)sclWaitingShow:(NSString *)title body:(NSString*)body{
    
    SCLAlertView * alert = [[self globalSelf] alert];
    
    [alert showWaiting:title
              subTitle:body
      closeButtonTitle:nil
              duration:0.0];
}

+(void)sclWaitingHide{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self globalSelf].aAlert hideView];
        [self globalSelf].aAlert = nil;
    });
}

+(UIFont*)getGlobalFont{
    UIFont * font = [self globalSelf].configFile.globalFont;
    return font ? font : [UIFont fontWithName:@"Avenir" size:18];
}

+(UIColor*)getGlobalColour{
    UIColor * colour = [self globalSelf].configFile.corperateColour;
    return colour ? colour : [UIColor lightGrayColor];
}

+(UIColor*)getBackgroundColour{
    UIColor * colour = [self globalSelf].configFile.background;
    return colour ? colour : [UIColor lightGrayColor];
}

-(NSAttributedString*)sclAttString:(NSString *)value{
    NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionary];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setAlignment:NSTextAlignmentCenter];
    
    [attrsDictionary setObject:[self alertTextColour] forKey:NSForegroundColorAttributeName];
    [attrsDictionary setObject:[GlobalSCL getGlobalFont] forKey:NSFontAttributeName];
    [attrsDictionary setObject:style forKey:NSParagraphStyleAttributeName];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:value
                                                                     attributes:attrsDictionary];
    
    return attrString;
}

+(void)updateAlertText:(NSString *)body{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self globalSelf].aAlert.viewText setText:body];
    });
}


+(void)showMessage:(NSString *)message forSeconds:(NSUInteger)seconds{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        SCLAlertView * messageAlert = [self sclGlobal];
        
        [messageAlert showEdit:nil
                      subTitle:message
              closeButtonTitle:nil
                      duration:seconds];
    });
}


//Sets dynamically, depending on the corperate colour
-(UIColor*)alertTextColour{

    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [[GlobalSCL getBackgroundColour] getRed:&red green:&green blue:&blue alpha:&alpha];
    
    float contrast = ((red*299) + (green*587) + (blue*114))/1000;
    BOOL isDark = contrast < 0.5 ? YES : NO;
    
    return isDark ? [UIColor lightTextColor] : [UIColor darkTextColor];
}


@end
