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
    //On will appear:
    
    //If user merely left screen -
        //then reload existing map points
        //stop region monitoring? (singleton)
    
    //If user loads new map
        //clear map points
        //remove all monitored regions (from shared location manager)
        //add new map points
        //add new map points to monitored regions (add to shared location manager)

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewRoute:) name:@"userLoadedNewRoute" object:nil];
    
    
    
//    if([self.selectedRouteDetailViewController routeData] ){
//        if (self.locationManager.monitoredRegions) {
//            //Clear out all monitored regions
//            for (CLCircularRegion *region in self.locationManager.monitoredRegions) {
//                [self.locationManager stopMonitoringForRegion:region];
//            }
//            
//            NSArray *routeAnnotations = [[[NSArray arrayWithObject:[self.selectedRouteDetailViewController routeData]] valueForKey:@"checkpoints"] objectAtIndex:0];
//            [self clearAllCheckpoints:nil];
//            
//            for (RouteCoordinate *coord in routeAnnotations) {
//                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//                CLLocationCoordinate2D location = CLLocationCoordinate2DMake([coord.latitude doubleValue], [coord.longitude doubleValue]);
//                CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location radius:coord.checkpointRadius identifier:coord.checkpointName];
//                
//                annotation.coordinate = location;
//                annotation.title      = coord.checkpointName;
//                [self.mapView addAnnotation:annotation];
//                [self.locationManager startMonitoringForRegion:region];
//            }
//        }
//    } else {

//    if (self.locationManager.monitoredRegions) {
//            if (self.mapView.annotations.count== 0) {
//                for (CLCircularRegion *region in self.locationManager.monitoredRegions) {
//                    MKPointAnnotation *annotation                            = [[MKPointAnnotation alloc] init];
//                    
//                    annotation.coordinate                                    = region.center;
//                    annotation.title                                         = region.identifier;
//                    [self.mapView addAnnotation:annotation];
//                }
//            }
//        }
    
    //}
    

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
//    self.locationManager                                     = [[CLLocationManager alloc]init];
//    self.locationManagerDelegate                             = [[LocationManagerDelegate alloc] init];
//    self.locationManager.delegate                            = self.locationManagerDelegate;
//    self.locationManager.desiredAccuracy                     = kCLLocationAccuracyNearestTenMeters;


    //Get user permission to use location services, then start monitoring
//    [self handleLocationServicesAuthorizationCheck];

    //Allocate long-press gesture recognizer
    self.mapLongPressGestureRecognizer                       = [[UILongPressGestureRecognizer alloc] init];
    self.mapLongPressGestureRecognizer.delegate              = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMapCheckpoints) name:@"userCancelledSave" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clearAllCheckpoints:(id)sender {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [[SharedLocationManager sharedInstance] clearAllMonitoredRegions];
    
//    for (CLCircularRegion *region in self.locationManager.monitoredRegions) {
//        [self.locationManager stopMonitoringForRegion:region];
//    }
    
    
}

- (void)longPressGestureHandler:(UITapGestureRecognizer*)tapGesture{
    if(tapGesture.state == UIGestureRecognizerStateBegan){
        [[self mapViewLocationManagerDelegate] updateMap:[tapGesture locationInView:tapGesture.view] locationManagerObject:[SharedLocationManager sharedInstance].locationManager mapViewToUpdate:self.mapView];
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
    [self loadNewRoute:[self.selectedRouteDetailViewController routeData]];
    
    
    if([self.selectedRouteDetailViewController routeData] ){
//        NSArray *routeData = [NSArray arrayWithObject:[self.selectedRouteDetailViewController routeData]];
//
//        for (RouteData *route in routeData) {
//            NSLog(@"%@", [route debugDescription]);
//            if ([[route valueForKey:@"checkpoints"] count] > 0) {
//                for (RouteCoordinate *coord in [route valueForKey:@"checkpoints"]) {
//                    NSLog(@"%@", [coord debugDescription]);
//                }
//            }
//        }
    }
}

-(void)loadNewRoute:(RouteData *)routeData{

    //Clear out all monitored regions
    [[SharedLocationManager sharedInstance] clearAllMonitoredRegions];
    
    NSArray *routeAnnotations = [[[NSArray arrayWithObject:routeData] valueForKey:@"checkpoints"] objectAtIndex:0];
    [self clearAllCheckpoints:nil];
    
    for (RouteCoordinate *coord in routeAnnotations) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([coord.latitude doubleValue], [coord.longitude doubleValue]);
        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location radius:coord.checkpointRadius identifier:coord.checkpointName];
        
        annotation.coordinate = location;
        annotation.title      = coord.checkpointName;
        [self.mapView addAnnotation:annotation];
        [[SharedLocationManager sharedInstance] addRegionToMonitor:region];
    }
}

-(void)reloadMapCheckpoints{
    [self.mapView removeAnnotations:self.mapView.annotations];
    for (CLCircularRegion *region in [[SharedLocationManager sharedInstance] getMonitoredRegions]) {
        MKPointAnnotation *annotation                            = [[MKPointAnnotation alloc] init];
        
        annotation.coordinate                                    = region.center;
        annotation.title                                         = region.identifier;
        
        
        [self.mapView addAnnotation:annotation];
        
    }
    NSLog(@"%@", [[self.mapView annotations] debugDescription]);
}

@end
