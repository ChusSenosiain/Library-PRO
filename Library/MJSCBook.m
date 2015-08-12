//
//  MJSCBook.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBook.h"
#import "MJSCBackendManager.h"


@implementation MJSCBook

-(id)initWithTitle:(NSString *)title
          subtitle:(NSString *)subtitle
            author:(NSString *)author
           summary:(NSString *)summary
          category:(NSString *)category
          imageURL:(NSURL *)imageURL
               URL:(NSURL *)URL
            bookID:(NSString *)bookID {
    
    if (self = [super init]) {
        _title = title;
        _subtitle = subtitle;
        _author = author;
        _summary = summary;
        _category = category;
        _imageURL = imageURL;
        _URL = URL;
        _bookID = bookID;
    }
    
    return self;
}


-(id)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        _bookID = [dictionary objectForKey:@"objectId"];
        _title = [dictionary objectForKey:@"title"];
        _subtitle = [dictionary objectForKey:@"subtitle"];
        _author = [dictionary objectForKey:@"author"];
        _summary = [dictionary objectForKey:@"summary"];
        _category = [dictionary objectForKey:@"category"];
        _imageURL = [NSURL URLWithString:[dictionary objectForKey:@"imageURL"]];
        _URL = [NSURL URLWithString:[dictionary objectForKey:@"URL"]];
        
        
    }
    
    return self;
    
}

-(void)loadBookDetails:(NSString *)bookID {
    
    
    MJSCBackendManager *backManager = [[MJSCBackendManager alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [backManager downloadBookDetail:bookID completionBlock:^(MJSCBook *book, NSError *error) {
        
        if (!error) {
            
            if (weakSelf) {
                
                __strong typeof (weakSelf) strongSelf = weakSelf;
                
                weakSelf.title = book.title;
                weakSelf.subtitle = book.title;
                weakSelf.author = book.author;
                weakSelf.summary = book.summary;
                weakSelf.category = book.category;
                weakSelf.imageURL = book.imageURL;
                weakSelf.URL = book.URL;
                weakSelf.bookID = book.bookID;
                
                if ([strongSelf.delegate respondsToSelector:@selector(bookDidFinishLoad)]) {
                    [strongSelf.delegate bookDidFinishLoad];
                }
            }
        }
    }];
    

}



@end
