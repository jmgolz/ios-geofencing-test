//
//  SelectedRouteDetailViewController.m
//  geofencingTest
//
//  Created by James Golz on 2/24/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "SelectedRouteDetailViewController.h"

@interface SelectedRouteDetailViewController ()

@end

@implementation SelectedRouteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(![self.routeData isEqual:nil]){
        self.routeAuthorLabel.text = self.routeData.routeAuthor;
        self.routeNameLabel.text   = self.routeData.routeName;
    }
    
    //for (RouteData *routeItem in fetchRouteRequestResults) {
        if([self.routeData valueForKey:@"checkpoints"]){
            NSLog(@"%@", [[self.routeData valueForKey:@"checkpoints"] debugDescription]);
            for (RouteCoordinate *coordinate in [self.routeData valueForKey:@"checkpoints"]) {
                NSLog(@"%@ Latitude: %f Longitude %f",[coordinate checkpointName], [coordinate.latitude floatValue], [coordinate.longitude floatValue]);
                MKPointAnnotation *checkpoint = [[MKPointAnnotation alloc] init];
                checkpoint.coordinate = CLLocationCoordinate2DMake([coordinate.latitude doubleValue], [coordinate.longitude doubleValue]);
                [self.routePathDisplayMap addAnnotation:checkpoint];
            }
        }
    //}
    
    MKCoordinateRegion region;
    MKCoordinateSpan   span;
    
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    region.center = [[[self.routePathDisplayMap annotations] objectAtIndex:0] coordinate];
    region.span = span;
    [self.routePathDisplayMap setRegion:region animated:YES];
    [self.routePathDisplayMap regionThatFits:region];
    
    
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
