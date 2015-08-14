//
//  MJSCLibrary.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBookManager.h"
#import "MJSCNetworkManager.h"
#import "Book.h"
#import "MJSCCoreDataStack.h"
#import "MJSCCoreDataManager.h"

@interface MJSCBookManager ()

@end

@implementation MJSCBookManager



-(NSUInteger)sectionCount {
    return [self.library count];
}


-(NSUInteger)countBooksAtSection:(NSUInteger) section {
    return [[self.library objectForKey:[self sectionKeyForSection:section]] count];
}


-(Book *)bookAtSection:(NSInteger) section
                 index:(NSUInteger) index {
    return [[self.library objectForKey:[self sectionKeyForSection:section]] objectAtIndex:index];
    
}


-(NSString *)sectionTitle:(NSUInteger)section {
    return [self sectionKeyForSection:section];
}

-(NSString *)sectionKeyForSection:(NSUInteger)section {
    return [[self.library allKeys] objectAtIndex:section];
}


-(void)loadBookDetails:(NSString *)bookID{
    
    // If the book doesn't exist or hasn't details, load it from Parse
    MJSCNetworkManager *netManager = [[MJSCNetworkManager alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [netManager downloadBookDetail:bookID completionBlock:^(NSDictionary *book, NSError *error) {
        if (weakSelf) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            NSString *bookId = [book objectForKey:@"objectId"];
            
            MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
            
            Book *coreDataBook = [coreManager bookWithDetails:bookId];
            
            // Save book details on CoreData
            if (!error) {
                [coreDataBook updateBookWithDictionary:book];
                
                MJSCCoreDataStack *coreDataStack = [MJSCCoreDataStack sharedInstance];
                [coreDataStack saveContext];
                
            } else {
                NSLog(@"There was an error downloading book details");
            }
            
            if ([strongSelf.delegate respondsToSelector:@selector(bookDidFinishLoad:)]) {
                [strongSelf.delegate bookDidFinishLoad:coreDataBook];
            }
        }
        
    }];
    
}


-(void)loadBooks {
    
    
    // Search the last updated date
    __block MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
    NSDate *lastLocalUpdatedBookDate = [coreManager lastUpdatedBookDate];
    NSArray *coreDataBooks = [coreManager allBooks:NO];
    
    if ([self.delegate respondsToSelector:@selector(libraryDidFinishLoad)]) {
        [self.delegate libraryDidFinishLoad];
    }
    
    
    // If there are no books, gets all the books. If there're books in core data, gets the
    // most recent updated books and update core data's books
    MJSCNetworkManager *backManager = [[MJSCNetworkManager alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [backManager downloadBooks:lastLocalUpdatedBookDate completionBlock:^(NSArray *books, NSError *error) {
        
        // Update CoreData books with downloaded book
        if (!error) {
            
            NSArray *bookIdsInBackend = [books valueForKey:@"objectId"];
            NSArray *bookMatchesInCoreDataByID = [coreManager booksIDsIncludedInBookIDList:bookIdsInBackend];
            NSArray *coreDataBooksID = [bookMatchesInCoreDataByID valueForKey:@"bookID"];
            
            
            MJSCCoreDataStack *coreDataStack = [MJSCCoreDataStack sharedInstance];

            for (NSString *bookIdInBackend in bookIdsInBackend) {
                
                NSInteger index = [bookIdsInBackend indexOfObject:bookIdInBackend];
                
                NSDictionary *bookDictionary = [books objectAtIndex:index];
                
                if ([coreDataBooksID containsObject:bookIdInBackend]) {
                    // The book is in coreData, update it
                    Book *book = [coreManager bookWithDetails:bookIdInBackend];
                    [book updateBookWithDictionary:bookDictionary];
                    
                } else {
                    // The book isn't in coreDAta, create it
                    [Book bookWithContext:coreDataStack.managedObjectContext dictionary:bookDictionary];
                }
            }
            
            [coreDataStack saveContext];
            
        }
        
        
        
        if (weakSelf) {
            
            __strong typeof (weakSelf) strongSelf = weakSelf;
            // Extract all books from CoreData
            NSArray *finalBooks = [coreManager allBooks:NO];
            
            NSMutableDictionary *tempLibrary = [[NSMutableDictionary alloc] init];
            
            // Create the library group by categories
            for (Book *book in finalBooks) {
                
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
                
            }
            
            strongSelf.library = [tempLibrary copy];
            
            if ([strongSelf.delegate respondsToSelector:@selector(libraryDidFinishLoad)]) {
                [strongSelf.delegate libraryDidFinishLoad];
            }
        }
        
        
        
    }];
}



@end
