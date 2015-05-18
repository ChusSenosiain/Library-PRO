//
//  UIViewController+Combinators.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "UIViewController+Combinators.h"

@implementation UIViewController (Combinators)

-(UINavigationController *) wrappedInNavigation{
    return [[UINavigationController alloc] initWithRootViewController:self];
}

@end