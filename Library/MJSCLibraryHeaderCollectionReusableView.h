//
//  MJSCLibraryHeaderCollectionReusableView.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;

@interface MJSCLibraryHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;

+(NSString*) headerID;

@end
