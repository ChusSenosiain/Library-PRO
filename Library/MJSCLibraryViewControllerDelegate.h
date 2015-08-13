//
//  MJSCLibraryViewControllerDelegate.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 19/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@class Book;

@protocol MJSCLibraryViewControllerDelegate <NSObject>

@optional

-(void)libraryViewController:(UIViewController *)libraryVC
               didSelectBook:(Book *)book
                   indexPath:(NSIndexPath *)indexPath;

@end
