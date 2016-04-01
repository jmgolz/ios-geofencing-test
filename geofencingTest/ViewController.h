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

#import "SharedLocationManager.h"
#import "LocationManagerDelegate.h"
#import "MapViewLocationUpdatesDelegate.h"
#import "SaveRouteScreenViewController.h"
#import "SelectedRouteDetailViewController.h"
#import "RouteData.h"
#import "RouteCoordinate.h"


@interface ViewController : UIViewController<UIGestureRecognizerDelegate>

@property CLLocationManager *locationManager;
@property LocationManagerDelegate *locationManagerDelegate;
@property MapViewLocationUpdatesDelegate *mapViewLocationManagerDelegate;

@property (strong, nonatomic) IBOutlet                 UILongPressGestureRecognizer   *mapLongPressGestureRecognizer;

@property (strong, nonatomic  ) IBOutlet                 MKMapView                      *mapView;
@property (weak, nonatomic  ) IBOutlet                 UILabel                        *scansLabel;
@property SelectedRouteDetailViewController *selectedRouteDetailViewController;
@property (strong, nonatomic) SaveRouteScreenViewController *saveRouteScreenController;

- (IBAction)clearAllCheckpoints:(id)sender;

- (void)longPressGestureHandler:(UITapGestureRecognizer*)tapGesture;
- (void)handleLocationServicesAuthorizationCheck;

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue;
-(IBAction)saveRoute:(id)sender;

-(void)loadNewRoute:(RouteData *)routeData;
@end

