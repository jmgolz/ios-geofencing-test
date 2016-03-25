//
//  ViewController.m
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    self.selectedRouteDetailViewController = [[SelectedRouteDetailViewController alloc] init];
    
    if (self.locationManager.monitoredRegions) {
        if (self.mapView.annotations.count== 0) {
            for (CLCircularRegion *region in self.locationManager.monitoredRegions) {
    MKPointAnnotation *annotation                            = [[MKPointAnnotation alloc] init];

    annotation.coordinate                                    = region.center;
    annotation.title                                         = region.identifier;
                [self.mapView addAnnotation:annotation];
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled      = YES;

    //Map init
    self.mapViewLocationManagerDelegate                      = [[MapViewLocationUpdatesDelegate alloc] init];
    self.mapView.delegate                                    = self.mapViewLocationManagerDelegate;
    self.mapView.showsUserLocation                           = YES;

    MKCoordinateRegion initialCoordinate                     = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 10, 10);

    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    [self.mapView setRegion:initialCoordinate animated:YES];

    //Begin location monitoring
    self.locationManager                                     = [[CLLocationManager alloc]init];
    self.locationManagerDelegate                             = [[LocationManagerDelegate alloc] init];
    self.locationManager.delegate                            = self.locationManagerDelegate;
    self.locationManager.desiredAccuracy                     = kCLLocationAccuracyNearestTenMeters;


    //Get user permission to use location services, then start monitoring
    [self handleLocationServicesAuthorizationCheck];

    //Allocate long-press gesture recognizer
    self.mapLongPressGestureRecognizer                       = [[UILongPressGestureRecognizer alloc] init];
    self.mapLongPressGestureRecognizer.delegate              = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clearAllCheckpoints:(id)sender {
    [self.mapView removeAnnotations:self.mapView.annotations];

    for (CLCircularRegion *region in self.locationManager.monitoredRegions) {
        [self.locationManager stopMonitoringForRegion:region];
    }
}

- (void)longPressGestureHandler:(UITapGestureRecognizer*)tapGesture{
    if(tapGesture.state == UIGestureRecognizerStateBegan){
        [[self mapViewLocationManagerDelegate] updateMap:[tapGesture locationInView:tapGesture.view] locationManagerObject:self.locationManager mapViewToUpdate:self.mapView];
    }
}


- (void)handleLocationServicesAuthorizationCheck{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager requestAlwaysAuthorization];
            return;

        case kCLAuthorizationStatusAuthorizedAlways:

            return;

        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            //[self showSorryAlert];
            return;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"segueToSaveRoute"]){
    SaveRouteScreenViewController *destinationViewController = [segue destinationViewController];
    destinationViewController.annotationsForStorage          = [self.mapView annotations];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    self.selectedRouteDetailViewController = [segue sourceViewController];
    
    if([self.selectedRouteDetailViewController routeData] ){
        NSArray *routeData = [NSArray arrayWithObject:[self.selectedRouteDetailViewController routeData]];

        for (RouteData *route in routeData) {
            NSLog(@"%@", [route debugDescription]);
            if ([[route valueForKey:@"checkpoints"] count] > 0) {
                for (RouteCoordinate *coord in [route valueForKey:@"checkpoints"]) {
                    NSLog(@"%@", [coord debugDescription]);
                }
            }
        }
    }
}

@end
