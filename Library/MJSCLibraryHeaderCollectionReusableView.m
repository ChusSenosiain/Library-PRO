//
//  MJSCLibraryHeaderCollectionReusableView.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryHeaderCollectionReusableView.h"
#import "Settings.h"

@implementation MJSCLibraryHeaderCollectionReusableView


+(NSString*)headerID{
    return [[self class] description];
}

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.backgroundColor = [[UIColor groupTableViewBackgroundColor] CGColor];
}

@end
