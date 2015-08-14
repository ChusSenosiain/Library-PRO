//
//  MJSCNotesViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class Book;
#import "MJSCCoreDataTableViewController.h"

@interface MJSCNotesViewController : MJSCCoreDataTableViewController


-(id)initWithBook:(Book*)book;


@end
