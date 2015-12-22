//
//  MapViewController.h
//  BlizkyServicios
//
//  Created by Pablo on 12/22/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MapKit;

@protocol MapViewControllerDelegate <NSObject>

-(void)goingBack:(MKPointAnnotation *) pin;

@end

@interface MapViewController : UIViewController

@property (strong, nonatomic) MKPointAnnotation *annotationPin;
@property (strong, nonatomic) id <MapViewControllerDelegate> delegate;

@end
