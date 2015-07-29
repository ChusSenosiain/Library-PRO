//
//  MJSCLibraryViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 15/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class MJSCLibrary;
@class MJSCBook;

#import "MJSCLibraryViewControllerDelegate.h"

#define BOOK_DID_CHANGE_NOTIFICATION @"bookDidChange"
#define BOOK_KEY @"book"

@interface MJSCLibraryViewController : UIViewController <MJSCLibraryViewControllerDelegate>

@property (weak, nonatomic) id<MJSCLibraryViewControllerDelegate>delegate;

-(id)initWithModel:(MJSCLibrary *)library;

@end
