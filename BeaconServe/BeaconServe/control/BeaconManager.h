//
//  BeaconManager.h
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCSIBeacon.h"

@interface BeaconManager : NSObject <KCSBeaconManagerDelegate>

@property (nonatomic ,strong) KCSBeaconManager *beaconManager;
@property (nonatomic ,strong) NSMutableArray *storedItems;

@property (nonatomic ,strong) NSString *lastUUID;

+ (id)sharedManager;

- (void)startItems;
- (void)stopItems;
- (void)invalidLastBeacon;

@end
