//
//  Book.h
//  
//
//  Created by María Jesús Senosiain Caamiña on 13/08/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * bookID;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet *book_notes;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addBook_notesObject:(Note *)value;
- (void)removeBook_notesObject:(Note *)value;
- (void)addBook_notes:(NSSet *)values;
- (void)removeBook_notes:(NSSet *)values;

@end
