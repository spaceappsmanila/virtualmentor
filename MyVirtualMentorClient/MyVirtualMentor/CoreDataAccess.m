//
//  CoreDataAccess.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "CoreDataAccess.h"
#import "AppDelegate.h"
#import "Member.h"
@implementation CoreDataAccess

-(id)init
{
    if (self=[super init]) {
        AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        self.context=appDelegate.managedObjectContext;
    }
    return self;
}

-(NSArray *)getAllUsers
{
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Member" inManagedObjectContext:_context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    //[request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"email" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1,nil];
    
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSArray *users = [[NSArray alloc]initWithArray:[_context executeFetchRequest:request error:&error]];
    if (users == nil)
    {
        // Deal with error...
    }
    if (users.count==0)
        
        return nil;
    else
    {
        return users;
    }
}


-(Member *)getUser: (NSString*)userName
{
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Member" inManagedObjectContext:_context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email ==[c] %@",userName];
    
    [request setPredicate:predicate];
    
    
    NSError *error = nil;
    NSArray *user = [[NSArray alloc]initWithArray:[_context executeFetchRequest:request error:&error]];
    if (user == nil)
    {
        // Deal with error...
    }
    if (user.count==0)        
        return nil;
    else
    {
        for (Member *thisUser in user)
        {
//            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//            appDelegate.thisUser = thisUser;            
            NSLog(@"ang user na nakuha mo ay si: %@ %@", thisUser.firstName, thisUser.lastName);
            

            return thisUser;
        }
    }
    
    return nil;
}

@end
