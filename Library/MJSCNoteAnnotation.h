//
//  MJSCNoteAnnotation.h
//  Library
//
//  Created by Ricardo Maqueda Martinez on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import MapKit;
@class Note;

@interface MJSCNoteAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) Note *note;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
