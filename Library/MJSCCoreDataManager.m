//
//  MJSCCoreDataManager.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCCoreDataManager.h"
#import "Book.h"
#import "Note.h"
#import "MJSCCoreDataStack.h"


@interface MJSCCoreDataManager ()
@property(nonatomic, strong) MJSCCoreDataStack *coreDataStack;
@end

@implementation MJSCCoreDataManager



-(id)init{
    
    if (self = [super init]) {
        _coreDataStack = [MJSCCoreDataStack sharedInstance];
    }
    
    return self;
}



-(Book*)bookWithDetails:(NSString *)bookID {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Book class])];
    request.predicate = [NSPredicate predicateWithFormat:@"bookID == %@", bookID];
    
    return [[self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil] firstObject];
    
}

-(NSArray*)allBooks:(BOOL)withDetails {
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Book class])];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"updatedAt" ascending:NO]];
    
    return [self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil];
    
}

-(NSArray*)allBooksIDs {
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Book class])];
    [request setPropertiesToFetch:@[@"bookID"]];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"updatedAt" ascending:NO]];
    
    return [self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil];
    
}


-(NSArray*)booksIDsIncludedInBookIDList:(NSArray *)booksIDs {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Book class])];
    [request setPredicate: [NSPredicate predicateWithFormat:@"(bookID IN %@)", booksIDs]];
    [request setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"updatedAt" ascending:NO]]];
    
    return [self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil];
    
    
}


-(NSDate*)lastUpdatedBookDate {
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Book class])];
    [request setPropertiesToFetch:@[@"updatedAt"]];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"updatedAt" ascending:NO]];
    [request setFetchLimit:1];
    
    return [[[self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil] firstObject] updatedAt];
}


-(NSArray*)bookNotes:(Book *)book{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Note class])];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"updatedAt" ascending:NO]];
    request.predicate = [NSPredicate predicateWithFormat:@"note_book = %@", book];
    
    return [self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil];
    
}


-(NSFetchedResultsController*)fetchedResultsControllerBookNotes:(Book *) book {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Note class])];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"updatedAt" ascending:NO]];
    request.predicate = [NSPredicate predicateWithFormat:@"note_book = %@", book];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
}



-(NSFetchedResultsController*)fetchedResultsControllerBooks {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Book class])];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"category" ascending:YES]];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.coreDataStack.managedObjectContext sectionNameKeyPath:@"category" cacheName:nil];
    
}





@end
