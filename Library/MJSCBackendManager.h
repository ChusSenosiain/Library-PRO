//
//  MJSCBackendManager.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 29/07/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@class Book;

@interface MJSCBackendManager : NSObject

-(AFHTTPRequestOperation *) downloadBooks:(NSDate *)updatedDate
                          completionBlock:(void(^)(NSArray *books, NSError *error))completion;

-(AFHTTPRequestOperation *)downloadBookDetail:(NSString *) bookId
          completionBlock:(void(^)(NSDictionary *book, NSError *error))completion;

@end
