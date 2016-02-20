//
//  ProjectAnnotation.h
//  BeaconServe
//
//  Created by AnCheng on 2/21/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ProjectAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

@property (nonatomic) BOOL isCurrent;

@end
