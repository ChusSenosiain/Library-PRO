//
//  MJSCLibraryTableViewCell.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class MJSCBook;

@interface MJSCLibraryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;


+(NSString*) cellId;
+(CGFloat) height;

-(void)configureWithBook:(MJSCBook *)book;



@end
