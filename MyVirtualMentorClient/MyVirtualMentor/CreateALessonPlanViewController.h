//
//  CreateALessonPlanViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/21/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreateALessonPlanViewController;

@protocol CreateALessonPlanViewControllerDelegate
- (void)savingALessonPlan:(CreateALessonPlanViewController *)controller;
@end


@interface CreateALessonPlanViewController : UIViewController 


@property (weak, nonatomic) id <CreateALessonPlanViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *txtFld_LessonName;

@property (weak, nonatomic) IBOutlet UITextView *txtVw_LessonDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtFld_Duration;
@end
