//
//  MJSCLibraryTableViewCell.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryTableViewCell.h"
#import "Settings.h"


@implementation MJSCLibraryTableViewCell


+(NSString*)cellId{
    return [[self class] description];
}

+(CGFloat) height{
    return 70;
}

- (void)awakeFromNib {
    
    self.bookImage.layer.cornerRadius = 2;
    self.bookImage.layer.borderWidth = 1;
    self.bookImage.layer.borderColor = [UIColorFromRGB(0xB6B6B6) CGColor];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
