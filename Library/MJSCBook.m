//
//  MJSCBook.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBook.h"

@implementation MJSCBook

-(id) initWithTitle:(NSString *) title
             author:(NSString *) author
             category:(NSString *) category {
    
    if (self = [super init]) {
        _title = title;
        _author = author;
        _category = category;
    }
    
    return self;
}



@end
