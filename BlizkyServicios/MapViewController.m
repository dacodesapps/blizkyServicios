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
    
    if (self.annotationPin) {
        [self.mapView showAnnotations:@[self.annotationPin] animated:YES];
    }
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
