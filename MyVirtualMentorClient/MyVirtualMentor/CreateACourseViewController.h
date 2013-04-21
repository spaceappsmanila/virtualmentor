//
//  CreateLessonPlanViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/20/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonPlanViewController.h"

@interface CreateACourseViewController : UIViewController <NSURLConnectionDelegate, LessonPlanViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFld_courseName;
@property (weak, nonatomic) IBOutlet UITextView *txtVw_courseDescription;
- (IBAction)saveLessonPlan:(id)sender;
- (IBAction)dismiss:(id)sender;
@end
