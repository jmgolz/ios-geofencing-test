//
//  SelectedRouteDetailViewController.h
//  geofencingTest
//
//  Created by James Golz on 2/24/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SelectedRouteDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *routePathDisplayMap;
@property (weak, nonatomic) IBOutlet UILabel *checkpointsAndDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeNameLabel;

@end
