//
//  MJSCNotesMapViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class Note;
@class Book;

#import "MJSCNoteViewControllerDelegate.h"

@interface MJSCNotesMapViewController : UIViewController

@property(weak, nonatomic)id<MJSCNoteViewControllerDelegate>delegate;

-(id)initWithNote:(Note *)note;
-(id)initWithBook:(Book *)book;

@end

