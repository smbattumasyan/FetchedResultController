//
//  CoreDataManager.h
//  test
//
//  Created by Smbat Tumasyan on 29.10.17.
//  Copyright © 2017 Smbat Tumasyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
+ (CoreDataManager *)createInstance;

@end
