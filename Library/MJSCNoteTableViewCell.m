//
//  MJSCNoteTableViewCell.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNoteTableViewCell.h"
#import "Note.h"

@implementation MJSCNoteTableViewCell

+(NSString*) cellId {
    
    return [[self class] description];
}


+(CGFloat) height {
    
    return 70;
    
}

-(void)configureWithNote:(Note *)note {
    
    self.noteTitle.text = [note title];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];

    self.noteDate.text = [dateFormat stringFromDate:[note updatedAt]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
