//
//  MJSCNoteViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@class Book;
@class Note;
@import UIKit;

@interface MJSCNoteViewController : UIViewController

-(id)initWithBook:(Book*)book
             page:(NSUInteger)page;


-(id)initWithNote:(Note*)note;

@end
