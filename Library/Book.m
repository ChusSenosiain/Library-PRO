#import "Book.h"

@interface Book ()

// Private interface goes here.

@end

@implementation Book



+(instancetype)bookWithContext:(NSManagedObjectContext*)context
                        author:(NSString*)author
                        bookID:(NSString*)bookID
                      category:(NSString*)category
                     createdAt:(NSDate*)createdAt
                      imageURL:(NSString*)imageURL
                          path:(NSString*)path
                      subtitle:(NSString*)subtitle
                       summary:(NSString*)summary
                         title:(NSString*)title
                     updatedAt:(NSDate*)updatedAt
                           url:(NSString*)url; {
    
    
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class) inManagedObjectContext:context];
    
    book.author = author;
    book.bookID = bookID;
    book.category = category;
    book.createdAt = createdAt;
    book.imageURL = imageURL;
    book.path = path;
    book.subtitle = subtitle;
    book.summary = summary;
    book.title = title;
    book.updatedAt = updatedAt;
    book.url = url;
    
    return book;

    
}


+(instancetype)bookWithContext:(NSManagedObjectContext*)context
                    dictionary:(NSDictionary*)dictionary {
    
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class) inManagedObjectContext:context];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    
    NSString *createdAtStringFormat = [dictionary objectForKey:@"createdAt"];
    NSString *updatedAtStringFormat = [dictionary objectForKey:@"updatedAt"];
    
    NSDate *createdAt = [dateFormatter dateFromString:createdAtStringFormat];
    NSDate *updatedAt = [dateFormatter dateFromString:updatedAtStringFormat];

    
    book.author = [dictionary objectForKey:@"author"];
    book.bookID = [dictionary objectForKey:@"objectId"];
    book.category = [dictionary objectForKey:@"category"];
    book.createdAt = createdAt;
    book.updatedAt = updatedAt;
    book.imageURL = [dictionary objectForKey:@"imageURL"];
    book.path = nil;
    book.subtitle = [dictionary objectForKey:@"subtitle"];
    book.summary = [dictionary objectForKey:@"summary"];
    book.title = [dictionary objectForKey:@"title"];
    book.url = [dictionary objectForKey:@"URL"];
    
    return book;

    
}


-(void)updateBookWithDictionary:(NSDictionary*)dictionary {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    
    NSString *createdAtStringFormat = [dictionary objectForKey:@"createdAt"];
    NSString *updatedAtStringFormat = [dictionary objectForKey:@"updatedAt"];
    
    NSDate *createdAt = [dateFormatter dateFromString:createdAtStringFormat];
    NSDate *updatedAt = [dateFormatter dateFromString:updatedAtStringFormat];
    
    
    self.author = [dictionary objectForKey:@"author"];
    self.bookID = [dictionary objectForKey:@"objectId"];
    self.category = [dictionary objectForKey:@"category"];
    self.createdAt = createdAt;
    self.updatedAt = updatedAt;
    self.imageURL = [dictionary objectForKey:@"imageURL"];
    self.path = nil;
    self.subtitle = [dictionary objectForKey:@"subtitle"];
    self.summary = [dictionary objectForKey:@"summary"];
    self.title = [dictionary objectForKey:@"title"];
    self.url = [dictionary objectForKey:@"URL"];
    
    
}





@end
