//
//  BeaconViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/25/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconViewController : UIViewController <UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic ,assign) IBOutlet UICollectionView *collectionView;

@end
