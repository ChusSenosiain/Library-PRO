//
//  MJSCTableViewHeader.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 20/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCTableViewHeader.h"

@interface MJSCTableViewHeader()
@property (weak, nonatomic) IBOutlet UIView *separator;
@end

@implementation MJSCTableViewHeader

+(NSString*)headerID {
    
    return [[self class] description];
}

+(CGFloat) height {
    
    return 30;
}

- (void)awakeFromNib {
    self.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.separator.backgroundColor = [MJSCStyles dividerColor];
}

@end
