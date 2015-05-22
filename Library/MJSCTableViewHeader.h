//
//  MJSCTableViewHeader.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 20/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;

@interface MJSCTableViewHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;

+(NSString*) headerID;
+(CGFloat) height;

@end
