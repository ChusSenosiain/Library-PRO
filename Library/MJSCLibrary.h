//
//  MJSCLibrary.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MJSCBook;

@interface MJSCLibrary : NSObject

@property (nonatomic, readonly) NSDictionary *library;
@property (nonatomic, readonly) NSUInteger sectionCount;


-(id) initWithBooks;

-(MJSCBook *) bookAtSection:(NSString *) section
                      index:(NSUInteger) index;

-(NSUInteger) countBooksAtSection:(NSString *) section;

@end
