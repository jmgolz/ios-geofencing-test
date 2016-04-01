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
    [self.navigationController setNavigationBarHidden:YES];
    
    if(![self.routeData isEqual:nil]){
        self.routeAuthorLabel.text = self.routeData.routeAuthor;
        self.routeNameLabel.text   = self.routeData.routeName;
    }
    
    if([self.routeData valueForKey:@"checkpoints"]){
        for (RouteCoordinate *coordinate in [self.routeData valueForKey:@"checkpoints"]) {
            MKPointAnnotation *checkpoint = [[MKPointAnnotation alloc] init];
            checkpoint.coordinate = CLLocationCoordinate2DMake([coordinate.latitude doubleValue], [coordinate.longitude doubleValue]);
            [self.routePathDisplayMap addAnnotation:checkpoint];
        }
    }
    
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