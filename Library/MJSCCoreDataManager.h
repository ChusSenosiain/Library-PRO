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

-(Book*)bookWithDetails:(NSString *)bookID;
-(NSArray*)allBooks:(BOOL)withDetails;
-(NSArray*)allBooksIDs;
-(NSDate*)lastUpdatedBookDate;
-(NSArray*)booksIDsIncludedInBookIDList:(NSArray *)booksIDs;

-(NSArray*)bookNotes:(Book *)book;
-(NSFetchedResultsController*)fetchedResultsControllerBookNotes:(Book *) book;


@end
