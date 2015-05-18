//
//  MJSCBookPDFViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 15/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@class MJSCBook;

@interface MJSCBookPDFViewController : UIViewController<UIWebViewDelegate>

-(id)initWithBook:(MJSCBook *)book;

@end
