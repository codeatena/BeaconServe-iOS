//
//  DirectionViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "DirectionViewController.h"
#import <MapKit/MapKit.h>
#import "ProjectAnnotation.h"

@interface DirectionViewController () <MKMapViewDelegate ,CLLocationManagerDelegate>

@property (nonatomic ,assign) IBOutlet MKMapView *mapView;

@end

@implementation DirectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;

    CALayer *btnLayer = [self.showBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    btnLayer.borderWidth = 1.0;
    btnLayer.borderColor = [UIColor clearColor].CGColor;
    
    _locations = [NSMutableArray new];
    
    // location manager setting
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onMenu:(id)sender
{
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:vc animated:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    CLLocation *currentLocation = [locations lastObject];
    // stop location update
    [manager stopUpdatingLocation];
    
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 100, 100);
    [self.mapView setRegion:newRegion animated:YES];
    
    ProjectAnnotation *currentAnotation = [ProjectAnnotation new];
    // currentAnotation.coordinate = currentAnotation.coordinate;
    currentAnotation.coordinate = [self locationWithBearing:0.0 distance:0 fromLocation:currentLocation.coordinate];
    currentAnotation.isCurrent = YES;

    // simulate project location away 5 feet from current location
    CLLocationCoordinate2D projectCoordinate = [self locationWithBearing:0.4 distance:20 fromLocation:currentLocation.coordinate];
    ProjectAnnotation *projectAnotation = [ProjectAnnotation new];
    projectAnotation.coordinate = projectCoordinate;
    projectAnotation.isCurrent = NO;
    
    [_mapView addAnnotation:currentAnotation];
    [_mapView addAnnotation:projectAnotation];
    
}

#pragma mark - MKMapViewDelegate
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{

    if ([annotation isKindOfClass:[ProjectAnnotation class]])
    {
        static NSString * const identifier = @"MyCustomAnnotation";
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView) {
            annotationView.annotation = annotation;
        } else {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
        }
        
        // set your annotationView properties        
        if ([(ProjectAnnotation *)annotation isCurrent])
            annotationView.image = [UIImage imageNamed:@"map_icon1"];
        else
            annotationView.image = [UIImage imageNamed:@"map_icon2"];
        
        NSLog(@"Display Pin !");
        
        return annotationView;
    }
    return nil;
}

- (CLLocationCoordinate2D) locationWithBearing:(float)bearing distance:(float)distanceMeters fromLocation:(CLLocationCoordinate2D)origin {
    CLLocationCoordinate2D target;
    const double distRadians = distanceMeters / (6372797.6); // earth radius in meters
    
    float lat1 = origin.latitude * M_PI / 180;
    float lon1 = origin.longitude * M_PI / 180;
    
    float lat2 = asin( sin(lat1) * cos(distRadians) + cos(lat1) * sin(distRadians) * cos(bearing));
    float lon2 = lon1 + atan2( sin(bearing) * sin(distRadians) * cos(lat1),
                              cos(distRadians) - sin(lat1) * sin(lat2) );
    
    target.latitude = lat2 * 180 / M_PI;
    target.longitude = lon2 * 180 / M_PI; // no need to normalize a heading in degrees to be within -179.999999° to 180.00000°
    
    return target;
}

@end
