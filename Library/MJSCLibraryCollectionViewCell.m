//
//  MJSCLibraryCollectionViewCell.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryCollectionViewCell.h"
#import "MJSCBook.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@implementation MJSCLibraryCollectionViewCell


+(NSString*)cellId {
    return [[self class] description];
}

- (void)awakeFromNib {
    self.clipsToBounds = YES;

    self.container.clipsToBounds = YES;
    self.container.layer.cornerRadius = 2;
    self.container.layer.borderWidth = 0.5;
    self.container.layer.borderColor = [[MJSCStyles dividerColor] CGColor];

}


-(void)configureWithBook:(MJSCBook *)book {
    self.bookTitle.text = book.title;
    [self.bookImage setImageWithURL:book.imageURL];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [self.bookImage cancelImageRequestOperation];
    self.bookImage.image = nil;
}


@end
