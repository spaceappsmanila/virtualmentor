//
//  CreateLessonPlanViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/21/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateALessonPlanViewController.h"
@class LessonPlanViewController;



@protocol LessonPlanViewControllerDelegate
- (void)createdALessonPlan:(LessonPlanViewController *)controller;
@end



@interface LessonPlanViewController : UITableViewController <CreateALessonPlanViewControllerDelegate>

@property (weak, nonatomic) id <LessonPlanViewControllerDelegate> delegate;

- (IBAction)addLessonPlan:(id)sender;
- (IBAction)done:(id)sender;
@end
