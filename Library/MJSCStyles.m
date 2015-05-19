//
//  MJSCStyles.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 19/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCStyles.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MJSCStyles

+(UIColor *)primaryColor {
    
    return UIColorFromRGB(0x03A9F4);
}

+(UIColor *)darkPrimaryColor {
    
    return UIColorFromRGB(0x03A9F4);
}

+(UIColor *)lightPrimaryColor {
    
    return UIColorFromRGB(0x03A9F4);
}

+(UIColor *)accentColor {
    
    return UIColorFromRGB(0x536DFE);
}

+(UIColor *)separatotColor {
    
    return UIColorFromRGB(0xB6B6B6);
}

+(void)configureAppearance{
    
    UIColor *background = [self primaryColor];
    
    [[UINavigationBar appearance] setBarTintColor:background];
    [[UIBarButtonItem appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:30]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



@end
