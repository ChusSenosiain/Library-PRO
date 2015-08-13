//
//  MJSCLibraryCollectionViewCell.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class Book;

@interface MJSCLibraryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UIView *container;

-(void)configureWithBook:(Book *)book;

+(NSString*)cellId;

@end
