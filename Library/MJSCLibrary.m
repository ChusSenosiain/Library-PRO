//
//  MJSCLibrary.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibrary.h"
#import "MJSCBook.h"
#import "MJSCBackendManager.h"
#import "Book.h"
#import "MJSCCoreDataStack.h"


@implementation MJSCLibrary


-(NSUInteger)sectionCount {
    return [self.library count];
}


-(NSUInteger)countBooksAtSection:(NSUInteger) section {
    return [[self.library objectForKey:[self sectionKeyForSection:section]] count];
}


-(MJSCBook *)bookAtSection:(NSInteger) section
                      index:(NSUInteger) index {
    MJSCBook *book = [[self.library objectForKey:[self sectionKeyForSection:section]] objectAtIndex:index];
    return book;
}


-(NSString *)sectionTitle:(NSUInteger)section {
    return [self sectionKeyForSection:section];
}

-(NSString *)sectionKeyForSection:(NSUInteger)section {
    return [[self.library allKeys] objectAtIndex:section];
}


-(void)loadBooks {
    
    MJSCBackendManager *backManager = [[MJSCBackendManager alloc] init];
    
    // Load books of core data by updatedDate
    MJSCCoreDataStack *coreDataStack = [MJSCCoreDataStack sharedInstance];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Book class])];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"updatedAt" ascending:NO]];
    
    NSArray *books = [coreDataStack.managedObjectContext executeFetchRequest:request error:nil];
    
    // Get the most recent update date
    NSDate *lastUpdate = [[books objectAtIndex:0] updatedAt];
    
    // If there are no books, gets all the books. If there're books in core data, gets the
    // most recent updated books and update core data's books
    __weak typeof(self) weakSelf = self;
    [backManager downloadBooks:lastUpdate completionBlock:^(NSArray *books, NSError *error) {
        
            if (!error) {
                
                NSMutableDictionary *tempLibrary = [[NSMutableDictionary alloc] init];
                
                MJSCCoreDataStack *coreDataStack = [MJSCCoreDataStack sharedInstance];
                
                // Create the library grouy by categories
                for (MJSCBook *book in books) {
                    
                    // Search the category in the dictionary
                    NSString *category = [book category];
                    if (!category) {
                        category = @"Sin categoria";
                    }
                    
                    NSMutableArray *array = [tempLibrary objectForKey:category];
                    
                    // The category doesn't existe, create it
                    if (!array) {
                        array = [[NSMutableArray alloc] init];
                    }
                    
                    // Add the book to the category
                    [array addObject:book];
                    
                    // Add the category with it's books to the library
                    [tempLibrary setObject:array forKeyedSubscript:category];
                    
                    
                    //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                    Book *coreBook = [Book bookWithContext:coreDataStack.managedObjectContext author:book.author bookID:book.bookID category:book.category createdAt:[NSDate date] imageURL:[book.imageURL absoluteString] path:@"test" subtitle:book.subtitle summary:book.summary title:book.title updatedAt:[NSDate date] url:[book.URL absoluteString]];
                    
                    [coreDataStack saveContext];
                    
                }
               
                if (weakSelf) {
                    __strong typeof (weakSelf) strongSelf = weakSelf;
                    
                    strongSelf.library = [tempLibrary copy];
                    
                    if ([strongSelf.delegate respondsToSelector:@selector(libraryDidFinishLoad)]) {
                        [strongSelf.delegate libraryDidFinishLoad];
                    }
                }
               
            }
    }];
}



@end
