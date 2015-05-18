//
//  MJSCLibraryTableViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//
@import UIKit;
@class MJSCLibrary;
@class MJSCBook;
@class MJSCLibraryTableViewController;

#import "MJSCLibraryViewController.h"

@interface MJSCLibraryTableViewController : UITableViewController

@property(weak, nonatomic) id<MJSCLibraryViewControllerDelegate> delegate;

-(id)initWithModel:(MJSCLibrary *)library;


@end
