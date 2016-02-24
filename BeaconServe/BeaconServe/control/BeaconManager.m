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
            self.beaconManager = [[KCSBeaconManager alloc] init];
            self.beaconManager.delegate = self;
            self.beaconManager.postsLocalNotification = YES;
            
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
        
        //[self startMonitoringItem:itemData];
        [self.beaconManager startMonitoringForRegion:itemData.uuid.UUIDString identifier:itemData.name error:nil];

    }
}

- (void)stopItems
{
    for (BeaconItem *itemData in _storedItems) {
        
        //[self stopMonitoringItem:itemData];
        [self.beaconManager stopMonitoringForRegion:itemData.name];
    }
}

- (CLBeaconRegion *)beaconRegionWithItem:(BeaconItem *)item {
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:item.uuid
                                                                           major:item.majorValue
                                                                           minor:item.minorValue
                                                                      identifier:item.name];
    return beaconRegion;
}

#pragma mark - KCSBeaconManagerDelegate
- (void) newNearestBeacon:(CLBeacon*)beacon
{

    // Beacon found!
    
    // You can retrieve the beacon data from its properties
    NSString *uuid = beacon.proximityUUID.UUIDString;
    
    NSLog(@"UUID is %@" ,uuid);
    
    if (uuid != nil && [uuid isEqualToString:BEACON1_UUID])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beacon1found" object:self];
    }
    else if (uuid != nil && [uuid isEqualToString:BEACON2_UUID])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beacon2found" object:self];
        
    }
    
}

- (NSString*) localNotificationMessageForBeacon:(CLBeaconRegion*)region event:(KCSIBeaconRegionEvent)eventCode
{
    // return message for local notification
    return nil;
}

@end
