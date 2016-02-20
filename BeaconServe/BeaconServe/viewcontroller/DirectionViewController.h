//
//  DirectionViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DirectionViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UIButton *showBtn;

@property (nonatomic ,strong) CLLocationManager *locationManager;
@property (nonatomic ,strong) NSMutableArray *locations;

@end
