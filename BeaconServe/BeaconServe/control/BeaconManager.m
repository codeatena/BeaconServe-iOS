//
//  BeaconManager.m
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "BeaconManager.h"
#import "BeaconItem.h"

@implementation BeaconManager 

+ (id)sharedManager
{
    static BeaconManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

- (id)init
{
    if (self = [super init])
    {
        self.beaconManager = [[KCSBeaconManager alloc] init];
        self.beaconManager.delegate = self;
        self.beaconManager.postsLocalNotification = YES;
        
        _storedItems = [NSMutableArray new];
        
        // Check if beacon monitoring is available for this device
        if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
            
            NSLog(@"Monitoring not available");
            
        }
        else
        {
            BeaconItem *item1 = [[BeaconItem alloc] initWithName:BEACON1_NAME uuid:BEACON1_UUID major:4660 minor:22136 type:BEACON_QUESTION];
            BeaconItem *item2 = [[BeaconItem alloc] initWithName:BEACON2_NAME uuid:BEACON2_UUID major:4660 minor:22136 type:BEACON_QUESTION];
            [_storedItems addObject:item1];
            [_storedItems addObject:item2];
        }
    }
    return self;
}

- (void)startItems
{
    for (BeaconItem *itemData in _storedItems) {
        
        [self.beaconManager startMonitoringForRegion:itemData.uuid identifier:itemData.name major:@(itemData.majorValue) minor:@(itemData.minorValue) error:nil];
    }
}

/*
 NSPredicate *predicateIrrelevantBeacons = [NSPredicate predicateWithFormat:@"(self.accuracy != -1) AND ((self.proximity != %d) OR (self.proximity != %d))", CLProximityFar,CLProximityUnknown];
 NSArray *relevantsBeacons = [beacons filteredArrayUsingPredicate: predicateIrrelevantBeacons];
 NSPredicate *predicateMin = [NSPredicate predicateWithFormat:@"self.accuracy == %@.@min.accuracy", relevantsBeacons];
 
 CLBeacon *closestBeacon = nil;
 NSArray *closestArray = [[relevantsBeacons filteredArrayUsingPredicate:predicateMin];
 if ([closestArray count] > 0)
 closestBeacon = [closestArray objectAtIndex:0];
 if (closestBeacon)
 { //Do your thing }
 else
 {//No relevant close beacon}
 */

#pragma mark - KCSBeaconManagerDelegate
- (void) newNearestBeacon:(CLBeacon*)beacon
{
    for (BeaconItem *itemData in _storedItems) {

        if ([itemData isEqualToCLBeacon:beacon])
        {
            // need to detect beacon type
            
            if (itemData.beaconType == BEACON_QUESTION)
            {
                // pop up question view
            }
            else if (itemData.beaconType == BEACON_LOCATION)
            {
                // record beacon number to CSV file
            }
            else  // if exit beacon
            {
                // need to detect if enter or exit
                // when exit and 2 types beacon is detected , trigger exit notification , complete question
            }
            
        }
    }
}

- (NSString*) localNotificationMessageForBeacon:(CLBeaconRegion*)region event:(KCSIBeaconRegionEvent)eventCode
{
    return nil;
}

@end
