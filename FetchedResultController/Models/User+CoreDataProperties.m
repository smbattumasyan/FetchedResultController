//
//  User+CoreDataProperties.m
//  test
//
//  Created by Smbat Tumasyan on 29.10.17.
//  Copyright © 2017 Smbat Tumasyan. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic name;
@dynamic surName;
@dynamic userID;

@end
