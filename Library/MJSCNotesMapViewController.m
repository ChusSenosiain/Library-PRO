//
//  MJSCNotesMapViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNotesMapViewController.h"
#import "Note.h"
#import "Book.h"
#import "MJSCCoreDataManager.h"

@import CoreLocation;
@import MapKit;


@interface MJSCNotesMapViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property(strong, nonatomic) Note *note;
@property(strong, nonatomic) Book *book;
@property(strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@end

@implementation MJSCNotesMapViewController

-(id)initWithNote:(Note *)note {

    if (self = [super init]) {
        _note = note;
    }
    
    return self;
}

-(id)initWithBook:(Book *)book {
    
    if (self = [super init]) {
        _book = book;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    
}


#pragma mark - MKMapViewDelegate


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {

    
}


#pragma mark - Utils

-(void)configureView {
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    // Pedir permisos al usuario
    [self.locationManager requestWhenInUseAuthorization];
    
    // Comenzar el servicio de localizacion
    [self.locationManager startUpdatingLocation];
    
    
    // Indicar posición del usuario
    self.map.showsUserLocation = YES;
  
    self.map.pitchEnabled = YES; // para inclinar
    self.map.delegate = self;

    
    if (self.book) {
        
        // Mostrar todas las chinchetas
        MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
        NSArray *notes = [coreManager bookNotes:self.book];
        
        for (Note *note in notes) {
            [self addNoteToMap:note applyZoom:NO];
        }
        
        // Hacer zoom al cuadro
        
        
    } else if (self.note) {
        [self addNoteToMap:self.note applyZoom:YES];
    }
    


}


-(void)addNoteToMap:(Note *)note
          applyZoom:(BOOL)applyZoom{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[note.latitude doubleValue] longitude:[note.longitude doubleValue]];
    MKAnnotationView *annotation = [[MKAnnotationView alloc] init];
    MKPointAnnotation *pointAnotation = [[MKPointAnnotation alloc] init];
    
    pointAnotation.coordinate = location.coordinate;
    pointAnotation.title = note.title;
    
    
    [self.map addAnnotation:pointAnotation];
    
    
    if (applyZoom) {
        
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
        [self.map setRegion:region animated:YES];

    }

}

@end
