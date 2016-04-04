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

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled      = YES;

    //Map init
    [SharedLocationManager sharedInstance];
    

    self.mapViewLocationManagerDelegate                      = [[MapViewLocationUpdatesDelegate alloc] init];
    self.mapView.delegate                                    = self.mapViewLocationManagerDelegate;
    self.mapView.showsUserLocation                           = YES;

    MKCoordinateRegion initialCoordinate                     = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 10, 10);

    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    [self.mapView setRegion:initialCoordinate animated:YES];


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
    [[SharedLocationManager sharedInstance] clearAllMonitoredRegions];
}

- (void)longPressGestureHandler:(UITapGestureRecognizer*)tapGesture{
    
    if(tapGesture.state == UIGestureRecognizerStateBegan){
        [[self mapViewLocationManagerDelegate] updateMap:[tapGesture locationInView:tapGesture.view] locationManagerObject:[SharedLocationManager sharedInstance].locationManager mapViewToUpdate:self.mapView];
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
    if (![[[segue sourceViewController] restorationIdentifier] isEqualToString:@"routesList"]){
        self.selectedRouteDetailViewController = [segue sourceViewController];
        [self loadNewRoute:[self.selectedRouteDetailViewController routeData]];
    }
}

- (IBAction)saveRoute:(id)sender {
    if (!self.saveRouteScreenController) {
        self.saveRouteScreenController = [self.storyboard instantiateViewControllerWithIdentifier:@"saveRoute"];
    }
    [self presentViewController:self.saveRouteScreenController animated:YES completion:nil];
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
@end
