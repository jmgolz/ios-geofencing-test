//
//  LocationManagerDelegate.h
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>

@interface LocationManagerDelegate : NSObject<CLLocationManagerDelegate>
@property AVSpeechSynthesizer *textToSpeechPlayer;
-(BOOL)isUserCurrentlyInGeofence:(CLCircularRegion*)region currentLocationObject:(CLLocation *)currentLocation;
-(void)checkpointAudioNotification:(NSString*)textForSpeech;
@end
