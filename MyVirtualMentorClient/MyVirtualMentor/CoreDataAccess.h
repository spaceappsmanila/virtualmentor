//
//  CoreDataAccess.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface CoreDataAccess : NSObject

@property(nonatomic,strong)NSManagedObjectContext *context;

-(NSArray *)getAllUsers;


-(Member *)getUser: (NSString*)userName;

@end
