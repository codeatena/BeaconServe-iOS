//
//  Global.h
//  BeaconServe
//
//  Created by AnCheng on 3/30/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

+ (id)sharedManager;

@property (nonatomic) BOOL enteredStore;
@property (nonatomic) BOOL detectedLocation;
@property (nonatomic) BOOL detectedQuestion;

- (void)initParams;

- (void)setParam:(id)value forKey:(NSString *)key;
- (id)getParam:(NSString *)key;
- (void)removeParam:(NSString *)key;

@end
