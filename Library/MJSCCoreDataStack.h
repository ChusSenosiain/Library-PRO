//
//  MJSCCoreDataStack.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 12/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MJSCCoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(MJSCCoreDataStack *)sharedInstance;

-(instancetype)init __attribute__((unavailable("init not available, use shareInstace...")));
-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;
-(void)autoSave:(BOOL)autosave;
- (void)zapAllData;
@end
