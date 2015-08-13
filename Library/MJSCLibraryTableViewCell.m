//
//  MJSCLibraryTableViewCell.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryTableViewCell.h"
#import "Book.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@implementation MJSCLibraryTableViewCell


+(NSString*)cellId {
    
    return [[self class] description];
}

+(CGFloat) height {
    
    return 70;
}

- (void)awakeFromNib {
    self.bookAuthor.textColor = [MJSCStyles secondaryTextColor];
    
    self.bookImage.layer.cornerRadius = 2;
    self.bookImage.layer.borderWidth = 0.5;
    self.bookImage.layer.borderColor = [[MJSCStyles dividerColor] CGColor];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleBlue];
}


-(void)configureWithBook:(Book *)book {
    self.bookTitle.text = book.title;
    self.bookAuthor.text = book.author;
    [self.bookImage setImageWithURL:[NSURL URLWithString:book.imageURL]];
    
    
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [self.bookImage cancelImageRequestOperation];
    self.bookImage.image = nil;
}




@end
