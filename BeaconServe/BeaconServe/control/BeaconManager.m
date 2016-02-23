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
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        
        // Check if beacon monitoring is available for this device
        if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
            
            NSLog(@"Monitoring not available");
            
        }
        else
        {
            NSUUID *uuid1 = [[NSUUID alloc] initWithUUIDString:BEACON1_UUID];
            NSUUID *uuid2 = [[NSUUID alloc] initWithUUIDString:BEACON2_UUID];
            BeaconItem *item1 = [[BeaconItem alloc] initWithName:BEACON1_PROXIMITY uuid:uuid1 major:1 minor:1];
            BeaconItem *item2 = [[BeaconItem alloc] initWithName:BEACON2_PROXIMITY uuid:uuid2 major:1 minor:1];
            [_storedItems addObject:item1];
            [_storedItems addObject:item2];

        }
    }
    return self;
}

- (void)loadItems
{
    for (BeaconItem *itemData in _storedItems) {
        
        [self startMonitoringItem:itemData];
    }
}

- (void)stopItems
{
    for (BeaconItem *itemData in _storedItems) {
        
        [self stopMonitoringItem:itemData];
    }
}

- (CLBeaconRegion *)beaconRegionWithItem:(BeaconItem *)item {
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:item.uuid
                                                                           major:item.majorValue
                                                                           minor:item.minorValue
                                                                      identifier:item.name];
    return beaconRegion;
}

- (void)startMonitoringItem:(BeaconItem *)item {
    CLBeaconRegion *beaconRegion = [self beaconRegionWithItem:item];
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)stopMonitoringItem:(BeaconItem *)item {
    CLBeaconRegion *beaconRegion = [self beaconRegionWithItem:item];
    [self.locationManager stopMonitoringForRegion:beaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion *)region
{
    // We entered a region, now start looking for our target beacons!
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion *)region
{
    // Exited the region
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    // Beacon found!
    
    CLBeacon *foundBeacon = [beacons firstObject];
    
    // You can retrieve the beacon data from its properties
    NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    
    NSLog(@"UUID is %@" ,uuid);
    
    if (uuid != nil && [uuid isEqualToString:BEACON1_UUID])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beacon1found" object:self];
    }
    else if (uuid != nil && [uuid isEqualToString:BEACON2_UUID])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beacon2found" object:self];

    }
    
    //NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    //NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Failed monitoring region: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

@end
