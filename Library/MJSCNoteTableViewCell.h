//
//  MJSCNoteTableViewCell.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class Note;

@interface MJSCNoteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *noteTitle;
@property (weak, nonatomic) IBOutlet UILabel *noteDate;

+(NSString*) cellId;
+(CGFloat) height;

-(void)configureWithNote:(Note *)note;

@end
