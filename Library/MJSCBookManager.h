//
//  MJSCLibrary.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import Foundation;
@class Book;

@protocol MJSCBookManagerDelegate <NSObject>

@optional

-(void)libraryDidFinishLoad;
-(void)bookDidFinishLoad:(Book *)book;

@end


@interface MJSCBookManager : NSObject

@property (weak, nonatomic) id<MJSCBookManagerDelegate> delegate;

-(void)loadBooks;

-(void)loadBookDetails:(NSString *)bookID;

@end
