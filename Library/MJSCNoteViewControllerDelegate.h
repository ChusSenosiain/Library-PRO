//
//  MJSCNoteViewControllerDelegate.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@class Note;

@protocol MJSCNoteViewControllerDelegate <NSObject>

@optional

-(void)didSelectNote:(Note *)note;

@end
