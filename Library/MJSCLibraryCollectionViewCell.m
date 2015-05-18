//
//  MJSCLibraryCollectionViewCell.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryCollectionViewCell.h"
#import "Settings.h"


@implementation MJSCLibraryCollectionViewCell


+(NSString*)cellId{
    return [[self class] description];
}

- (void)awakeFromNib {
    
    
    //self.layer.borderWidth = 0.5f;
    self.clipsToBounds = YES;
    
    self.container.clipsToBounds = YES;
    self.container.layer.cornerRadius = 2;
    self.container.layer.borderWidth = 1;
    self.container.layer.borderColor = [UIColorFromRGB(0xB6B6B6) CGColor];
     
}

@end
