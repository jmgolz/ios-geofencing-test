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
    NSError *fetchDataError                        = nil;
    NSFetchRequest *dataRequest                    = [NSFetchRequest fetchRequestWithEntityName:@"RouteData"];
    [dataRequest includesSubentities];
    dataRequest.relationshipKeyPathsForPrefetching = [NSArray arrayWithObjects:@"RouteDataCheckpoints", nil];
    self.storedRoutes                              = [[RouteStorageManager alloc] init];
    self.fetchResults                              = [[self.storedRoutes routeStorageDataContext] executeFetchRequest:dataRequest error:&fetchDataError];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RouteData *routeItem            = [self.fetchResults objectAtIndex:indexPath.row];

    self.tableCell                  = [tableView dequeueReusableCellWithIdentifier:@"routeInfoCell"];
    self.tableCell.routeAuthor.text = routeItem.routeAuthor;
    self.tableCell.routeName.text   = routeItem.routeName;
    
    return self.tableCell;
}
@end