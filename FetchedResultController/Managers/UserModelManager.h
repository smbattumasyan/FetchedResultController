//
//  UserModelManager.h
//  test
//
//  Created by Smbat Tumasyan on 29.10.17.
//  Copyright © 2017 Smbat Tumasyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"
#import "User+CoreDataProperties.h"


@interface UserModelManager : NSObject

@property (nonnull, strong, nonatomic ) CoreDataManager *coreDataManager;
@property(strong, nonatomic)NSFetchedResultsController * _Nullable fetchedResultsController;

+ (UserModelManager *_Nullable)createInstance;
- (void)addUsers:(NSArray *_Nullable)users;

@end
