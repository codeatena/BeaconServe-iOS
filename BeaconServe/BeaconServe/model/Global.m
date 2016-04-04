//
//  Global.m
//  BeaconServe
//
//  Created by AnCheng on 3/30/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (id)sharedManager
{
    static Global *sharedManager = nil;
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
        _enteredStore = NO;
        _detectedLocation = NO;
        _detectedQuestion = NO;
        
    }
    return self;
}

- (void)initParams
{
    _enteredStore = NO;
    _detectedLocation = NO;
    _detectedQuestion = NO;
}

- (void)setParam:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)getParam:(NSString *)key
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)removeParam:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
