//
//  MJSCLibrary.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibrary.h"
#import "MJSCBackendManager.h"
#import "Book.h"
#import "MJSCCoreDataStack.h"
#import "MJSCCoreDataManager.h"

@interface MJSCLibrary ()

@property(nonatomic, strong) MJSCCoreDataStack *coreDataStack;
@property(nonatomic, strong) MJSCCoreDataManager *coreDataManager;

@end

@implementation MJSCLibrary


-(id)init{
    
    if (self = [super init]) {
        _coreDataStack = [MJSCCoreDataStack sharedInstance];
        _coreDataManager = [[MJSCCoreDataManager alloc] init];
    }
    
    
    return self;
}


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
    MJSCBackendManager *backManager = [[MJSCBackendManager alloc] init];
    
    
    __weak typeof(self) weakSelf = self;
    
    [backManager downloadBookDetail:bookID completionBlock:^(NSDictionary *book, NSError *error) {
        if (weakSelf) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            NSString *bookId = [book objectForKey:@"objectId"];
            
            Book *coreDataBook = [strongSelf.coreDataManager loadBookWithDetails:bookId];
            
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
    
    
    // Load books of CoreData by updatedDate
    NSDate *lastLocalUpdatedBookDate = [self.coreDataManager lastUpdatedBookDate];
    
    

    
    // If there are no books, gets all the books. If there're books in core data, gets the
    // most recent updated books and update core data's books
    MJSCBackendManager *backManager = [[MJSCBackendManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [backManager downloadBooks:lastLocalUpdatedBookDate completionBlock:^(NSArray *books, NSError *error) {
        
        if (!error) {
            
            MJSCCoreDataStack *coreDataStack = [MJSCCoreDataStack sharedInstance];
            
            NSArray *bookIdsInBackend = [books valueForKey:@"objectId"];
            
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:
             [NSEntityDescription entityForName:@"Book" inManagedObjectContext:coreDataStack.managedObjectContext]];
            [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"(bookID IN %@)", bookIdsInBackend]];
            
            // make sure the results are sorted as well
            [fetchRequest setSortDescriptors:
             @[[[NSSortDescriptor alloc] initWithKey: @"updatedAt" ascending:NO]]];
            
            
            NSError *error;
            NSArray *bookMatchesInCoreDataById = [coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            NSArray *coreDataBooksID = [bookMatchesInCoreDataById valueForKey:@"bookID"];
            
            
            if (weakSelf) {
                
                __strong typeof (weakSelf) strongSelf = weakSelf;
                
                
                for (NSString *bookIdInBackend in bookIdsInBackend) {
                    
                    NSInteger index = [bookIdsInBackend indexOfObject:bookIdInBackend];
                    NSDictionary *bookDictionary = [books objectAtIndex:index];
                    
                    if ([coreDataBooksID containsObject:bookIdInBackend]) {
                        Book *book = [strongSelf.coreDataManager loadBookWithDetails:bookIdInBackend];
                        [book updateBookWithDictionary:bookDictionary];
                        
                    } else {
                        // No existe, crear NSManagedObject
                        [Book bookWithContext:coreDataStack.managedObjectContext dictionary:bookDictionary];
                    }
                }
                
                [coreDataStack saveContext];
                
                
                NSArray *finalBooks = [strongSelf.coreDataManager loadAllBooks:NO];
                
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
            
        }
    }];
}



@end
