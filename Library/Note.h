#import "_Note.h"

@interface Note : _Note



+(instancetype)noteWithContext:(NSManagedObjectContext*)context
                       address:(NSString*)address
                      bookPage:(NSNumber*)bookPage
                     createdAt:(NSDate*)createdAt
                         image:(NSString*)image
                      latitude:(NSNumber*)latitude
                     longitude:(NSNumber*)longitude
                          text:(NSString*)text
                     updatedAt:(NSDate*)updatedAt;

@end
