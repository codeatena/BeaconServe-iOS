//
//  ProjectEntity+CoreDataProperties.h
//  BeaconServe
//
//  Created by AnCheng on 2/22/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *projectname;
@property (nullable, nonatomic, retain) NSData *picture1;
@property (nullable, nonatomic, retain) NSData *picture2;

@end

NS_ASSUME_NONNULL_END
