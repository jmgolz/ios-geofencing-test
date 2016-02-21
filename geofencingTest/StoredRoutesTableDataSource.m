//
//  StoredRoutesTableDataSource.m
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "StoredRoutesTableDataSource.h"

@implementation StoredRoutesTableDataSource

- (id)init{
    self = [super init];
    
    if(!self){
        return nil;
    }
    
    [self getDataSet];
    return self;
}

- (void)getDataSet{
    NSError *fetchDataError = nil;
    NSFetchRequest *dataRequest = [NSFetchRequest fetchRequestWithEntityName:@"RouteData"];
    self.storedRoutes = [[RouteStorageManager alloc] init];
    self.fetchResults = [[self.storedRoutes routeStorageDataContext] executeFetchRequest:dataRequest error:&fetchDataError];
    
    NSLog(@"Getting reults in table view... %@", self.fetchResults.debugDescription);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Number of rows... %i", [[NSNumber numberWithInteger:self.fetchResults.count] intValue]);
    return self.fetchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RouteData *routeItem = [self.fetchResults objectAtIndex:indexPath.row];
    NSLog(@"Author: %@ and title: %@ at index: %i", routeItem.routeAuthor, routeItem.routeName, [[NSNumber numberWithInteger:indexPath.row] intValue]);
    
    self.tableCell = [tableView dequeueReusableCellWithIdentifier:@"routeInfoCell"];
    self.tableCell.routeAuthor.text = routeItem.routeAuthor;
    self.tableCell.routeName.text  = routeItem.routeName;
    
    return self.tableCell;
}
@end