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


-(void)loadBookDetails:(NSString *)bookID{
    
    // If the book doesn't exist or hasn't details, load it from Parse
    MJSCNetworkManager *netManager = [[MJSCNetworkManager alloc] init];
    
    MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
    
    __block Book *coreDataBook = [coreManager bookWithDetails:bookID];
    
    // First return the coreData book
    if ([self.delegate respondsToSelector:@selector(bookDidFinishLoad:)]) {
        [self.delegate bookDidFinishLoad:coreDataBook];
    }
    
    // Then search it on network and update it
    __weak typeof(self) weakSelf = self;
    
    [netManager downloadBookDetail:bookID completionBlock:^(NSDictionary *book, NSError *error) {
        if (weakSelf) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            // Save book details on CoreData
            if (!error) {
                [coreDataBook updateBookWithDictionary:book];
                
                if (!coreDataBook.category) {
                    coreDataBook.category = @"Sin categoría";
                }
                
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
                
                Book *book = nil;
                
                if ([coreDataBooksID containsObject:bookIdInBackend]) {
                    // The book is in coreData, update it
                    book = [coreManager bookWithDetails:bookIdInBackend];
                    [book updateBookWithDictionary:bookDictionary];
                    
                } else {
                    // The book isn't in coreDAta, create it
                    book =[Book bookWithContext:coreDataStack.managedObjectContext dictionary:bookDictionary];
                }
                
                if (!book.category) {
                    book.category = @"Sin categoría";
                }
                
            }
            
            [coreDataStack saveContext];
            
        }
        
        if (weakSelf) {
            
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            if ([strongSelf.delegate respondsToSelector:@selector(libraryDidFinishLoad)]) {
                [strongSelf.delegate libraryDidFinishLoad];
            }
        }
        
    }];
}



@end
