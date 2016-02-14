//
//  LocationManagerDelegate.m
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "LocationManagerDelegate.h"


@implementation LocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@",error.description);

}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *crnLoc = [locations lastObject];
    
    //Can we get zip code?
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:crnLoc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //NSLog(@"ZIP CODE: %@", [[[placemarks objectAtIndex:0] addressDictionary] objectForKey:@"ZIP"]);
        
        //NSLog(@"lat: %f long: %f", crnLoc.coordinate.latitude, crnLoc.coordinate.longitude);
        //NSLog(@"Address: %@", [[[placemarks objectAtIndex:0] addressDictionary] objectForKey:@"FormattedAddressLines"]);
    }];
    
    
    
    
}

//Delegate methods for geofencing
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"Monitoring regions");
    [manager requestStateForRegion:region];
    
    
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    switch (state) {
        case CLRegionStateInside:
            //NSLog(@"Started inside of region: %@", region.identifier);
            break;
            
        case CLRegionStateOutside:
            //NSLog(@"Started OUTSIDE of region: %@", region.identifier);
            break;
            
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"Entered %@", region.identifier);
    NSString *textForSpeaking = [NSString stringWithFormat:@"Entered %@",region.identifier];
    [self checkpointAudioNotification:textForSpeaking];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"Exited %@", region.identifier);
    NSString *textForSpeaking = [NSString stringWithFormat:@"Exited %@",region.identifier];
    [self checkpointAudioNotification:textForSpeaking];

}

-(BOOL)isUserCurrentlyInGeofence:(CLCircularRegion*)region currentLocationObject:(CLLocation *)currentLocation{
    
    return YES;
}

-(void)checkpointAudioNotification:(NSString*)textForSpeech{
    AVSpeechUtterance *textForSpokenWord = [[AVSpeechUtterance alloc] initWithString:textForSpeech];
    textForSpokenWord.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    
    self.textToSpeechPlayer = [[AVSpeechSynthesizer alloc] init];
    [self.textToSpeechPlayer speakUtterance:textForSpokenWord];
}

@end
