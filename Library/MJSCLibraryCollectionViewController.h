//
//  MJSCLibraryCollectionViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@import Foundation;
@class MJSCBookManager;

#import "MJSCLibraryViewControllerDelegate.h"

@interface MJSCLibraryCollectionViewController : UIViewController<UICollectionViewDataSource>

@property (weak, nonatomic) id<MJSCLibraryViewControllerDelegate>delegate;

-(id)initWithModel:(MJSCBookManager*)library;

@end
