//
//  CreateALessonPlanViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/21/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "CreateALessonPlanViewController.h"

@interface CreateALessonPlanViewController ()

@end

@implementation CreateALessonPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *btn_saveLesson = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveLesson)];
    
    self.navigationItem.rightBarButtonItem = btn_saveLesson;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveLesson
{
    NSString *param = [NSString stringWithFormat:@"\"Lessons\": {\"Lesson_0\" :{\"description\":\"%@\", \"name\":\"%@\", \"duration\":\"%@\", \"owner\":\"3\"}}", self.txtVw_LessonDescription.text, self.txtFld_LessonName.text, self.txtFld_Duration.text];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:param forKey:@"lessonPlan"];
    
    [self.delegate savingALessonPlan:self];
    
    
}




@end
