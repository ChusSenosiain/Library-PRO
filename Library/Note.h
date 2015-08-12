//
//  Note.h
//  
//
//  Created by María Jesús Senosiain Caamiña on 12/08/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSNumber * bookPage;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) Book *note_book;

@end
