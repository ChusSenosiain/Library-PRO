#import "Note.h"

@interface Note ()

// Private interface goes here.

@end

@implementation Note

+(instancetype)noteWithContext:(NSManagedObjectContext*)context
                       address:(NSString*)address
                      bookPage:(NSNumber*)bookPage
                     createdAt:(NSDate*)createdAt
                         image:(NSString*)image
                      latitude:(NSNumber*)latitude
                     longitude:(NSNumber*)longitude
                          text:(NSString*)text
                         title:(NSString*)title
                     updatedAt:(NSDate*)updatedAt{
    
    
    
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class) inManagedObjectContext:context];
    note.address = address;
    note.bookPage = bookPage;
    note.createdAt = createdAt;
    note.title = title;
    
    // TODO: ver como se carga la imagen, aquí pongo un string pero es un NSData
    //note.image = image;
    note.latitude = latitude;
    note.longitude = longitude;
    note.text = text;
    note.updatedAt = updatedAt;
    
    return note;

    
}

@end
