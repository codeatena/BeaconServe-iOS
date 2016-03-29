//
//  BeaconItem.h
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    BEACON_QUESTION,
    BEACON_LOCATION,
    BEACON_EXIT
    
}BEACON_TYPE ;

@interface BeaconItem : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *uuid;
@property (assign, nonatomic, readonly) CLBeaconMajorValue majorValue;
@property (assign, nonatomic, readonly) CLBeaconMinorValue minorValue;

@property (nonatomic) BEACON_TYPE beaconType;

- (instancetype)initWithName:(NSString *)name
                        uuid:(NSString *)uuid
                       major:(CLBeaconMajorValue)major
                       minor:(CLBeaconMinorValue)minor type:(BEACON_TYPE)type;

- (BOOL)isEqualToCLBeacon:(CLBeacon *)beacon;

@end
