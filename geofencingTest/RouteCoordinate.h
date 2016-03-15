//
//  RouteCoordinate.h
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface RouteCoordinate : NSManagedObject

@property NSString  *checkpointName;
@property NSInteger checkpointOrder;
@property NSInteger checkpointRadius;
@property NSNumber  *latitude;
@property NSNumber  *longitude;

@end
