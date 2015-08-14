//
//  MJSCNoteAnnotation.m
//  Library
//
//  Created by Ricardo Maqueda Martinez on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNoteAnnotation.h"

@implementation MJSCNoteAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {

    if (self = [super init]) {
        _coordinate = coordinate;
    }

    return self;
}

@end
