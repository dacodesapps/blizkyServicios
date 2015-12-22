//
//  MapViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/22/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureOnMap:)];
    [self.mapView addGestureRecognizer:tapGesture];
    
    if (self.annotationPin) {
        if (self.annotationPin.coordinate.longitude == self.mapView.userLocation.coordinate.longitude && self.annotationPin.coordinate.latitude == self.mapView.userLocation.coordinate.latitude) {
            self.mapView.showsUserLocation = NO;
        }
        [self.mapView showAnnotations:@[self.annotationPin] animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    if (self.delegate) {
        [self.delegate goingBack:self.annotationPin];
    }
    [super viewWillDisappear:animated];
}

-(void)handleTapGestureOnMap:(UIGestureRecognizer *) sender {
    CGPoint point = [sender locationInView:self.mapView];
    CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    if (!self.annotationPin) {
        self.annotationPin = [MKPointAnnotation new];
    }
    self.annotationPin.coordinate = locCoord;
    
    // [mapView showAnnotations:@[mapAnnotationPin] animated:YES];
    [self.mapView addAnnotation:self.annotationPin];
    self.mapView.showsUserLocation = YES;
}

- (IBAction)zoomToUserLocationButtonPressed:(id)sender {
    if (!self.annotationPin) {
        self.annotationPin = [MKPointAnnotation new];
    }
    
    self.annotationPin.coordinate = self.mapView.userLocation.coordinate;
    [self.mapView showAnnotations:@[self.annotationPin] animated:YES];
    self.mapView.showsUserLocation = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
