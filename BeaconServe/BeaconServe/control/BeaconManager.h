//
//  BeaconManager.h
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KCSIBeacon/KCSIBeacon.h>

@interface BeaconManager : NSObject <CLLocationManagerDelegate ,KCSBeaconManagerDelegate>

@property (nonatomic ,strong) NSMutableArray *storedItems;
@property (nonatomic ,strong) KCSBeaconManager *beaconManager;

+ (id)sharedManager;

- (void)startItems;
- (void)stopItems;

@end
