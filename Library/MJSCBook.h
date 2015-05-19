//
//  MJSCBook.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface MJSCBook : NSObject
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *category;
@property(strong, nonatomic) NSURL *imageURL;
@property(strong, nonatomic) NSURL *URL;


-(id) initWithTitle:(NSString *)title
           subtitle:(NSString *)subtitle
             author:(NSString *)author
            summary:(NSString *)summary
           category:(NSString *)category
           imageURL:(NSURL *)imageURL
                URL:(NSURL *)URL;


@end
