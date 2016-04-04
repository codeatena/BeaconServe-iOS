//
//  BeaconManager.m
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "BeaconManager.h"
#import "BeaconItem.h"
#import "AppDelegate.h"

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
            BeaconItem *item1 = [[BeaconItem alloc] initWithName:BEACON1_NAME uuid:BEACON1_UUID major:4660 minor:22136 type:BEACON_EXIT number:1];
            BeaconItem *item2 = [[BeaconItem alloc] initWithName:BEACON2_NAME uuid:BEACON2_UUID major:4660 minor:22136 type:BEACON_QUESTION number:2];
            BeaconItem *item3 = [[BeaconItem alloc] initWithName:BEACON3_NAME uuid:BEACON3_UUID major:4660 minor:22136 type:BEACON_LOCATION number:3];

            [_storedItems addObject:item1];
            [_storedItems addObject:item2];
            [_storedItems addObject:item3];

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

- (void)stopItems
{
    for (BeaconItem *itemData in _storedItems) {
        
        [self.beaconManager stopMonitoringForRegion:itemData.name];
    }
}

- (void)invalidLastBeacon
{
    [self.beaconManager invalidLastBeacon];
}

#pragma mark - KCSBeaconManagerDelegate
- (void) newNearestBeacon:(CLBeacon*)beacon
{
    for (BeaconItem *itemData in _storedItems) {

        if ([itemData isEqualToCLBeacon:beacon])
        {
            // need to detect beacon type
            
            if (itemData.beaconType == BEACON_QUESTION)
            {
                [[Global sharedManager] setDetectedQuestion:YES];
                // pop up question view when rssi > -72 DB
                if (beacon.rssi >= - 72)
                {
                    // pop up question view
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"questionbeaconfound" object:self userInfo:nil];

                }
                
            }
            else if (itemData.beaconType == BEACON_LOCATION)
            {
                [[Global sharedManager] setDetectedLocation:YES];
                // record beacon number to CSV file
                [[Global sharedManager] setParam:[NSString stringWithFormat:@"%ld" ,(long)itemData.deviceNumber] forKey:kClosestQuestionBeaconNumber];
                
            }
            else  // if exit beacon
            {
                
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                // need to detect if enter or exit
                // when exit and 2 types beacon is detected , trigger exit notification , complete question
                
                if ([[Global sharedManager] enteredStore])
                {
                    [delegate stopTimer];
                    [self stopItems];

                    [[Global sharedManager] setEnteredStore:NO];
                    
                    if ([[Global sharedManager] detectedLocation] && [[Global sharedManager] detectedQuestion])
                    {
                        // exit from store
                        // show LastStepViewController to complete question
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"exitbeaconfound" object:self userInfo:nil];

                    }
                }
                else
                {
                    [delegate startTimer];
                    [[Global sharedManager] setEnteredStore:YES]; // entered store
                }
            }
            
        }
    }
}

- (NSString*) localNotificationMessageForBeacon:(CLBeaconRegion*)region event:(KCSIBeaconRegionEvent)eventCode
{
    return nil;
}

@end
