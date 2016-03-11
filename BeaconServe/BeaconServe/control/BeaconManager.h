//
//  BeaconManager.h
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KCSIBeacon/KCSIBeacon.h>

@interface BeaconManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic ,strong) NSMutableArray *storedItems;
@property (strong, nonatomic) CLLocationManager *locationManager;

+ (id)sharedManager;

- (void)startItems;

@end
