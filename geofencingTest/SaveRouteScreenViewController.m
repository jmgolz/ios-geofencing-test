//
//  SaveRouteScreenViewController.m
//  geofencingTest
//
//  Created by James Golz on 2/19/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "SaveRouteScreenViewController.h"

@interface SaveRouteScreenViewController ()

@end

@implementation SaveRouteScreenViewController

-(void)viewWillAppear:(BOOL)animated{
    self.routeStorageManager          = [[RouteStorageManager alloc] init];

    //Get data if we have it...
    NSError *dataRequestError         = nil;
    NSFetchRequest *fetchSavedRoute   = [NSFetchRequest fetchRequestWithEntityName:@"RouteData"];
    NSArray *fetchRouteRequestResults = [[self.routeStorageManager routeStorageDataContext] executeFetchRequest:fetchSavedRoute error:&dataRequestError];

    for (RouteData *routeItem in fetchRouteRequestResults) {
        if([routeItem valueForKey:@"checkpoints"]){
            NSLog(@"%@", [[routeItem valueForKey:@"checkpoints"] debugDescription]);
            for (RouteCoordinate *coordinate in [routeItem valueForKey:@"checkpoints"]) {
                NSLog(@"%@:, Latitude: %f Longitude %f",[coordinate checkpointName], [coordinate.latitude floatValue], [coordinate.longitude floatValue]);
            }
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)saveRoute:(id)sender {

    //Create managed object, attach context to it
    RouteData *routeDataManagedObject  = [NSEntityDescription insertNewObjectForEntityForName:@"RouteData" inManagedObjectContext:self.routeStorageManager.routeStorageDataContext];
    routeDataManagedObject.routeAuthor = self.authorTextField.text;
    routeDataManagedObject.routeName   = self.routeNameTextField.text;

    NSMutableSet *routeCoordinatesSet  = [routeDataManagedObject mutableSetValueForKeyPath:@"checkpoints"];
    for (NSArray<id<MKAnnotation>> *annotation in self.annotationsForStorage) {

        MKPointAnnotation *mapAnnotation              = (MKPointAnnotation*)annotation;
        RouteCoordinate *routeCoordinateManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"RouteDataCheckpoints" inManagedObjectContext:self.routeStorageManager.routeStorageDataContext];
        routeCoordinateManagedObject.checkpointName   = mapAnnotation.title;
        routeCoordinateManagedObject.latitude         = [NSNumber numberWithDouble:mapAnnotation.coordinate.latitude];
        routeCoordinateManagedObject.longitude        = [NSNumber numberWithDouble:mapAnnotation.coordinate.longitude];

        routeCoordinateManagedObject.checkpointRadius = 0;
        routeCoordinateManagedObject.checkpointOrder  = 0;
        [routeCoordinatesSet addObject:routeCoordinateManagedObject];
    }
    [routeDataManagedObject setValue:routeCoordinatesSet forKeyPath:@"checkpoints"];

    NSError *routeSaveError = nil;
    [[self.routeStorageManager routeStorageDataContext] insertObject:routeDataManagedObject];
    [[self.routeStorageManager routeStorageDataContext] save:&routeSaveError];

    if (routeSaveError != nil) {
        [self makeRouteSavedDialog:NO];
        NSLog(@"%@", routeSaveError.localizedDescription);
    } else {
        //Check the data got saved
        [self makeRouteSavedDialog:YES];
    NSError *dataRequestError         = nil;
    NSFetchRequest *fetchSavedRoute   = [NSFetchRequest fetchRequestWithEntityName:@"RouteData"];
    NSArray *fetchRouteRequestResults = [[self.routeStorageManager routeStorageDataContext] executeFetchRequest:fetchSavedRoute error:&dataRequestError];

        if (!fetchRouteRequestResults) {
            NSLog(@"%@",dataRequestError.localizedDescription);
        } else {
            NSLog(@"Got results: %@", fetchRouteRequestResults.debugDescription);
        }
    }
}

- (IBAction)cancelRouteSave:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userCancelledSave" object:self.annotationsForStorage];
}

- (void)makeRouteSavedDialog:(BOOL)didSaveRecord{
    NSString *title;
    NSString *body;

    if(didSaveRecord == YES){
        title = @"Success!";
        body  = @"Successfully saved route.";
    } else {
        title = @"Error!";
        body  = @"There was a problem saving your route.";
    }
    UIAlertController *dialog = [UIAlertController alertControllerWithTitle:title message:body preferredStyle:UIAlertControllerStyleAlert];
    [dialog addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:dialog animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
