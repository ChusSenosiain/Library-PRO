//
//  MJSCNotesTableViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class Book;
@class Note;

#import "MJSCCoreDataTableViewController.h"

@protocol MJSCNotesTableViewControllerDelegate <NSObject>

@optional

-(void)didSelectNote:(Note *)note;

@end


@interface MJSCNotesTableViewController : MJSCCoreDataTableViewController

@property(weak, nonatomic)id<MJSCNotesTableViewControllerDelegate>delegate;

-(id)initWithBook:(Book*)book;


@end
