//
//  BeaconManager.h
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic ,strong) NSMutableArray *storedItems;

+ (id)sharedManager;

- (void)loadItems;
- (void)stopItems;

@end
