//
//  MJSCLibrary.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import Foundation;
@class MJSCBook;

@interface MJSCLibrary : NSObject

@property (nonatomic, copy) NSDictionary *library;
@property (nonatomic, readonly) NSUInteger sectionCount;


-(id) initWithBooks;

-(MJSCBook *)bookAtSection:(NSInteger)section
                      index:(NSUInteger)index;

-(NSUInteger)countBooksAtSection:(NSUInteger)section;

-(NSString *)sectionTitle:(NSUInteger)section;

@end
