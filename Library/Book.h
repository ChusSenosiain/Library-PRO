#import "_Book.h"

@interface Book : _Book {}


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
                           url:(NSString*)url;



+(instancetype)bookWithContext:(NSManagedObjectContext*)context
                    dictionary:(NSDictionary*)dictionary;





@end
