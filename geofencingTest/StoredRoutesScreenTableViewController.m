//
//  StoredRoutesScreenTableViewController.m
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "StoredRoutesScreenTableViewController.h"

@interface StoredRoutesScreenTableViewController ()

@end

@implementation StoredRoutesScreenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableDataSource      = [[StoredRoutesTableDataSource alloc] init];
    self.tableView.dataSource = self.tableDataSource;
    self.tableView.delegate   = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RouteData *routeData = [self.tableDataSource.fetchResults objectAtIndex:indexPath.row];
//    for (RouteData *routeItem in fetchRouteRequestResults) {
        if([routeData valueForKey:@"checkpoints"]){
            NSLog(@"%@", [[routeData valueForKey:@"checkpoints"] debugDescription]);
            for (RouteCoordinate *coordinate in [routeData valueForKey:@"checkpoints"]) {
                NSLog(@"Latitude: %f Longitude %f", [coordinate.latitude floatValue], [coordinate.longitude floatValue]);
            }
        }
//    }

    
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
