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
    }
    return self;
}

- (void)loadItems
{
    for (BeaconItem *itemData in _storedItems) {
        
        [self startMonitoringItem:itemData];
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
    
    //CLBeacon *foundBeacon = [beacons firstObject];
    
    // You can retrieve the beacon data from its properties
    //NSString *uuid = foundBeacon.proximityUUID.UUIDString;
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
