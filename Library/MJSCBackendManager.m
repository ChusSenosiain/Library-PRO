//
//  MJSCBackendManager.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 29/07/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBackendManager.h"
#import <AFNetworking/AFNetworking.h>
#import "MJSCBook.h"

#define PARSE_BOOK_URL @"https://api.parse.com/1/classes/Book"

#define PARSE_APP_ID @"ZKJq1pKzGnS0FNVo5XceDodJvXlKmqOJbXQt0npf"
#define PARSE_REST_API_KEY @"CTbE9vEIJD0plhtFrx8VVucBxgiky5TIMUtJSChx"


@implementation MJSCBackendManager


-(AFHTTPRequestOperation *)downloadBooks:(NSDate *)updatedDate
                         completionBlock:(void(^)(NSArray *books, NSError *error))completion {
    
    AFHTTPRequestOperationManager *manager = [self prepareRequestOperationManager];
    AFHTTPRequestOperation *operation;
    
    
    NSDictionary *params;
    
    // Download the books that are updated
    NSString *queryDate = nil;
    
    if (updatedDate) {
        
        /*2015-07-29T07:19:59.376Z*/
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        
        queryDate = [dateFormatter stringFromDate:updatedDate];
        
        NSDictionary *dateCompare = [[NSDictionary alloc] initWithObjectsAndKeys:queryDate, @"$gt", nil];
        NSDictionary *whereClausule = [[NSDictionary alloc] initWithObjectsAndKeys:dateCompare, @"updatedAt", nil];
        
        params = [[NSDictionary alloc] initWithObjectsAndKeys:@"title,author,imageURL,category", @"keys"
                 , whereClausule, @"where"
                 , @"updatedAt", @"order", nil];

    } else {
        params = [[NSDictionary alloc] initWithObjectsAndKeys:@"title,author,imageURL,category", @"keys"
                  , @"updatedAt", @"order", nil];
    }
    
    operation = [manager GET:PARSE_BOOK_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseString = [operation responseString];
        
        NSDictionary *json = [NSJSONSerialization
                         JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]
                         options:kNilOptions
                         error:nil];
        
        
        NSArray *JSONBooks = [json objectForKey:@"results"];
        NSMutableArray *books = [NSMutableArray array];
        
        for (NSDictionary *book in JSONBooks) {
            MJSCBook *parsedBook = [[MJSCBook alloc] initWithDictionary:book];
            [books addObject:parsedBook];
        }
        
        completion(books, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    

    
    return operation;
    
}





-(AFHTTPRequestOperation *)downloadBookDetail:(NSString *) bookId
                              completionBlock:(void(^)(MJSCBook *book, NSError *error))completion {
    
    
    AFHTTPRequestOperationManager *manager = [self prepareRequestOperationManager];
    AFHTTPRequestOperation *operation;
    
    NSString *bookDetailURL = [NSString stringWithFormat:@"%@%@%@", PARSE_BOOK_URL, @"/", bookId];
    
    operation = [manager GET:bookDetailURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *resposeString = [operation responseString];
        
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:[resposeString dataUsingEncoding:NSUTF8StringEncoding]
                              options:kNilOptions
                              error:nil];
        
        MJSCBook *book = [[MJSCBook alloc] initWithDictionary:json];
        
        completion(book, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
    
    return operation;

    
}



-(AFHTTPRequestOperationManager *)prepareRequestOperationManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:PARSE_APP_ID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:PARSE_REST_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    
    return manager;
    
}


-(void)cancelOperation:(AFHTTPRequestOperation*)operation {
    
    [operation cancel];
    operation = nil;
}


-(void)cancelAllRequestOperations {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.operationQueue cancelAllOperations];
    
}

        



@end
