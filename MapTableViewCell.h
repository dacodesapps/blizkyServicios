//
//  MapTableViewCell.h
//  BlizkyServicios
//
//  Created by Pablo on 12/14/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MapTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *goToCurrentLocation;


@end
