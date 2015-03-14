//
//  MJSCBook.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJSCBook : NSObject
@property(nonatomic, strong) NSString *author;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *category;
-(id) initWithTitle:(NSString *) title
             author:(NSString *) author
           category:(NSString *) category;
@end
