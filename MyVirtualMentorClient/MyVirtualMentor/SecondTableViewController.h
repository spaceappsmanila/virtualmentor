//
//  SecondTableViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/19/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailViewController;

@interface SecondTableViewController : UITableViewController


@property (strong, nonatomic) DetailViewController *detailViewController;

@property(nonatomic, strong) NSString *classType;


@end
