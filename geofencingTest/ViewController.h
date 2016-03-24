//
//  ViewController.h
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "LocationManagerDelegate.h"
#import "MapViewLocationUpdatesDelegate.h"
#import "SaveRouteScreenViewController.h"
#import "SelectedRouteDetailViewController.h"


@interface ViewController : UIViewController<UIGestureRecognizerDelegate>

@property CLLocationManager *locationManager;
@property LocationManagerDelegate *locationManagerDelegate;
@property MapViewLocationUpdatesDelegate *mapViewLocationManagerDelegate;

@property (strong, nonatomic) IBOutlet                 UILongPressGestureRecognizer   *mapLongPressGestureRecognizer;

@property (weak, nonatomic  ) IBOutlet                 MKMapView                      *mapView;
@property (weak, nonatomic  ) IBOutlet                 UILabel                        *scansLabel;
@property SelectedRouteDetailViewController *selectedRouteDetailViewController;

- (IBAction)clearAllCheckpoints:(id)sender;

- (void)longPressGestureHandler:(UITapGestureRecognizer*)tapGesture;
- (void)handleLocationServicesAuthorizationCheck;

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue;
@end

