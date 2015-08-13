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
    
    book.author = [dictionary objectForKey:@"author"];
    book.bookID = [dictionary objectForKey:@"objectId"];
    book.category = [dictionary objectForKey:@"category"];
    
    // TODO, ver como se cargan las fechas desde un dicctionario
    //book.createdAt = createdAt;
    //book.updatedAt = updatedAt;
    
    book.imageURL = [dictionary objectForKey:@"imageURL"];
    book.path = nil;
    book.subtitle = [dictionary objectForKey:@"subtitle"];
    book.summary = [dictionary objectForKey:@"summary"];
    book.title = [dictionary objectForKey:@"title"];
    book.url = [dictionary objectForKey:@"URL"];
    
    return book;

    
}



@end
