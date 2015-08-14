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


@import MapKit;


@interface MJSCNotesMapViewController ()<MKMapViewDelegate>
@property(strong, nonatomic) Note *note;
@property(strong, nonatomic) Book *book;
@property(strong, nonatomic) CLLocationManager *locationManager;
@property(strong, nonatomic) CLLocation *location;
@property(copy, nonatomic) NSString *address;

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

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Indicar posición del usuario
    self.map.showsUserLocation = YES;
    self.map.userTrackingMode = MKUserTrackingModeFollow;
    
    self.map.pitchEnabled = YES; // para inclinar
    self.map.delegate = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.map.userTrackingMode = MKUserTrackingModeNone;
    self.map.delegate = nil;
    
}




#pragma mark - MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    self.location = userLocation.location;
    
    // Geocodificación inversa
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    __weak typeof (self) weakSelf = self;
    [geocoder reverseGeocodeLocation:self.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            
            if (weakSelf) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                strongSelf.address = [NSString stringWithFormat:@"%@, %@",
                                [placemark thoroughfare],
                                [placemark locality]];
                
            }
        }
    }];

}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
 
    // TODO: extraer nota y ir al detalle de la nota
    Note *note = nil;
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectNoteOnMap:)]) {
        [self.delegate didSelectNoteOnMap:note];
    }
    
}


#pragma mark - Actions

-(IBAction)saveLocation:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didSelectLocation:withAddress:)]) {
        [self.delegate didSelectLocation:self.location withAddress:self.address];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Utils

-(void)configureView {
    
    self.locationManager = [[CLLocationManager alloc] init];
    /*self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self; */
    
    // Pedir permisos al usuario
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // Comenzar el servicio de localizacion
    /*[self.locationManager startUpdatingLocation];*/
    
    
    
    if (self.book) {
        
        // Mostrar todas las chinchetas
        MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
        NSArray *notes = [coreManager bookNotes:self.book];
        
        
        for (Note *note in notes) {
             [self addNoteToMap:note applyZoom:NO];
        }
        
        [self.map showAnnotations:self.map.annotations animated:YES];
        
    } else {
        
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveLocation:)];
        self.navigationItem.rightBarButtonItem = saveButton;

        self.map.userTrackingMode = MKUserTrackingModeNone;
        
        [self addNoteToMap:self.note applyZoom:YES];
    }
    
    


}


-(void)addNoteToMap:(Note *)note
          applyZoom:(BOOL)applyZoom{
    
    if (!note) {
        return;
    }
    
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
