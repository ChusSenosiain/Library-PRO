//
//  MJSCLibraryTableViewCell.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryTableViewCell.h"
#import "MJSCBook.h"
#import "Settings.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@implementation MJSCLibraryTableViewCell


+(NSString*)cellId {
    
    return [[self class] description];
}

+(CGFloat) height {
    
    return 70;
}

- (void)awakeFromNib {
    self.bookImage.layer.cornerRadius = 2;
    self.bookImage.layer.borderWidth = 1;
    self.bookImage.layer.borderColor = [[MJSCStyles separatotColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)configureWithBook:(MJSCBook *)book {
    self.bookTitle.text = book.title;
    self.bookAuthor.text = book.author;
    [self.bookImage setImageWithURL:book.imageURL];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [self.bookImage cancelImageRequestOperation];
    self.bookImage.image = nil;
}

@end
