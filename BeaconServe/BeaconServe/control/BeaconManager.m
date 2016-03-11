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
        _storedItems = [NSMutableArray new];
        
        // Check if beacon monitoring is available for this device
        if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
            
            NSLog(@"Monitoring not available");
            
        }
        else
        {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            [self.locationManager requestAlwaysAuthorization];

            NSUUID *uuid1 = [[NSUUID alloc] initWithUUIDString:BEACON1_UUID];
            NSUUID *uuid2 = [[NSUUID alloc] initWithUUIDString:BEACON2_UUID];
            BeaconItem *item1 = [[BeaconItem alloc] initWithName:BEACON1_NAME uuid:uuid1 major:4660 minor:22136];
            BeaconItem *item2 = [[BeaconItem alloc] initWithName:BEACON2_NAME uuid:uuid2 major:4660 minor:22136];
            [_storedItems addObject:item1];
            [_storedItems addObject:item2];
        }
    }
    return self;
}

- (void)startItems
{
    for (BeaconItem *itemData in _storedItems) {
        
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:itemData.uuid identifier:itemData.name];
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        // launch app when display is turned on and inside region
        region.notifyEntryStateOnDisplay = YES;
        
        [self.locationManager startMonitoringForRegion:region];
    }
}

- (CLBeaconRegion *)beaconRegionWithItem:(BeaconItem *)item {
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:item.uuid
                                                                           major:item.majorValue
                                                                           minor:item.minorValue
                                                                      identifier:item.name];
    return beaconRegion;
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entered Reion");
    
    if (region.identifier.length != 0) {
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {

    NSLog(@"Exited Reion");

    if (region.identifier.length != 0) {

        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    // Beacon found!
    if (beacons.count == 0) return;
   
    CLBeacon *beacon = [beacons firstObject];
    // You can retrieve the beacon data from its properties
    NSString *uuid = beacon.proximityUUID.UUIDString;
    if (uuid != nil) NSLog(@"UUID is %@" ,uuid);
    
    if (uuid != nil && [uuid isEqualToString:BEACON1_UUID])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beacon1found" object:self userInfo:@{@"name" : BEACON1_NAME ,@"uuid" : BEACON1_UUID}];
    }
    else if (uuid != nil && [uuid isEqualToString:BEACON2_UUID])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beacon2found" object:self userInfo:@{@"name" : BEACON2_NAME ,@"uuid" : BEACON2_UUID}];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]] && state == CLRegionStateInside) {
        [self locationManager:manager didEnterRegion:region];
    }
}

- (void)locationManager:(CLLocationManager *) manager didStartMonitoringForRegion:(CLRegion *) region {
    [manager requestStateForRegion:region];
}

@end
