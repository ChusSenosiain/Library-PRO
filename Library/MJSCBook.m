//
//  MJSCBook.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBook.h"


@implementation MJSCBook

-(id)initWithTitle:(NSString *)title
          subtitle:(NSString *)subtitle
            author:(NSString *)author
           summary:(NSString *)summary
          category:(NSString *)category
          imageURL:(NSURL *)imageURL
               URL:(NSURL *)URL; {
    
    if (self = [super init]) {
        _title = title;
        _subtitle = subtitle;
        _author = author;
        _summary = summary;
        _category = category;
        _imageURL = imageURL;
        _URL = URL;
    }
    
    return self;
}


-(id)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        _title = [dictionary objectForKey:@"title"];
        _subtitle = [dictionary objectForKey:@"subtitle"];
        _author = [dictionary objectForKey:@"author"];
        _summary = [dictionary objectForKey:@"summary"];
        _category = [dictionary objectForKey:@"category"];
        _imageURL = [dictionary objectForKey:@"imageURL"];
        _URL = [dictionary objectForKey:@"URL"];
        
    }
    
    return self;
    
}


@end
