//
//  MJSCLibraryViewControllerDelegate.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 19/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@class MJSCBook;

@protocol MJSCLibraryViewControllerDelegate <NSObject>

@optional

-(void)libraryViewController:(UIViewController *)libraryVC
               didSelectBook:(MJSCBook *)book
                   indexPath:(NSIndexPath *)indexPath;

@end
