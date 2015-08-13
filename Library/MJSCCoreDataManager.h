//
//  MJSCCoreDataManager.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import Foundation;
@import CoreData;
@class Book;
@class Note;

@interface MJSCCoreDataManager : NSObject

@property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

-(Book*)loadBookWithDetails:(NSString *)bookID;
-(NSArray*)loadAllBooks:(BOOL)withDetails;
-(NSArray*)loadAllBooksIDs;
-(NSDate*)lastUpdatedBookDate;

-(NSArray*)loadBookNotes:(Book *)book;


@end
