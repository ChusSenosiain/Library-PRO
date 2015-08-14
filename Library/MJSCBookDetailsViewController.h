//
//  MJSCBookDetailsViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
#import "Book.h"
#import "MJSCLibraryViewControllerDelegate.h"
#import "MJSCBookManager.h"

@interface MJSCBookDetailsViewController : UIViewController <UISplitViewControllerDelegate, MJSCLibraryViewControllerDelegate, MJSCBookManagerDelegate>

-(id)initWithBook:(Book*) book;

@end
