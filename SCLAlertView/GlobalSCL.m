//
//  GlobalSCL.m
//  SCLAlertView
//
//  Created by Luke Sadler on 09/05/2016.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

#import "GlobalSCL.h"

static GlobalSCL * global;

@interface GlobalSCL()


@property (nonatomic, strong) SCLAlertView *aAlert;
@property (nonatomic, strong) SCLConfig *configFile;;

@end

@implementation GlobalSCL

+(void)alertConfig:(SCLConfig *)config{
    [self globalSelf].configFile = config;
}

+(SCLAlertView *)sclGlobalWithNewWindow:(BOOL)newWindow{
    
    if ([[self globalSelf].aAlert isVisible]) {
        [[self globalSelf].aAlert hideView];
        return [self sclGlobalWithNewWindow:newWindow];
    }
    
    SCLAlertView * alert = [[self globalSelf] alertWithNewWindow:newWindow];
    [alert removeTopCircle];
    return alert;
}

+(GlobalSCL*)globalSelf{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[GlobalSCL alloc]init];
    });
    
    return global;
}

-(SCLAlertView*)alertWithNewWindow:(BOOL)newWindow{
    if (!_aAlert) {
        
        __weak typeof(self) weakSelf = self;
        
        _aAlert = newWindow ? [[SCLAlertView alloc]initWithNewWindow] : [[SCLAlertView alloc]init];
        [_aAlert setCustomViewColor: self.configFile.corperateColour ? self.configFile.corperateColour : [UIColor lightGrayColor]];
        _aAlert.attributedFormatBlock = ^NSAttributedString* (NSString *value)
        {
            return [weakSelf sclAttString:value];
        };
        
        [_aAlert setBackgroundType:Transparent];
        [_aAlert setShowAnimationType:FadeIn];
        [_aAlert setHideAnimationType:FadeOut];
        
        [_aAlert alertIsDismissed:^{
            _aAlert = nil;
        }];
        
    }
    return _aAlert;
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

+(void)sclWaitingShow:(NSString*)title
                 body:(NSString*)body{
    
    SCLAlertView * alert = [[self globalSelf] alertWithNewWindow:YES];
    [alert removeTopCircle];
    
    [alert showInfo:body ? title : nil
           subTitle:body ? body : title
   closeButtonTitle:nil
           duration:0.0];
}

+(void)sclWaitingHide{
    [[[self globalSelf] alertWithNewWindow:NO] hideView];
    NSLog(@"hiding");
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

+(void)showMessage:(NSString *)title withBody:(NSString *)body forSeconds:(NSUInteger)seconds{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [[self sclGlobalWithNewWindow:NO] showEdit:[self topMostController]
                             title:body ? title : nil
                          subTitle:body ? body : title
                  closeButtonTitle:nil
                          duration:seconds];
    });
}

+(void)showMessage:(NSString *)message forSeconds:(NSUInteger)seconds{
    [self showMessage:nil
             withBody:message
           forSeconds:seconds];
}


//Sets dynamically, depending on the corperate colour
-(UIColor*)alertTextColour{
    
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [[GlobalSCL getBackgroundColour] getRed:&red green:&green blue:&blue alpha:&alpha];
    
    float contrast = ((red*299) + (green*587) + (blue*114))/1000;
    BOOL isDark = contrast < 0.5 ? YES : NO;
    
    return isDark ? [UIColor lightTextColor] : [UIColor darkTextColor];
}

#pragma mark - Getter methods


+(BOOL)areAllTitlesUppercase{
    return [self globalSelf].configFile.titlesUpperCase;
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
@end
