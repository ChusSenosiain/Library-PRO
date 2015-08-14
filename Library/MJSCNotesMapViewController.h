//
//  MJSCNotesMapViewController.h
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

@import UIKit;
@import CoreLocation;
@class Note;
@class Book;

@protocol MJSCNotesMapViewControllerDelegate <NSObject>

@optional

-(void)didSelectLocation:(CLLocation *)location
             withAddress:(NSString *) address;


-(void)didSelectNoteOnMap:(Note *)note;

@end

@interface MJSCNotesMapViewController : UIViewController

@property(weak, nonatomic)id<MJSCNotesMapViewControllerDelegate>delegate;


-(id)initWithNote:(Note *)note;
-(id)initWithBook:(Book *)book;

@end

