//
//  UserTypePickerViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "UserTypePickerViewController.h"

@interface UserTypePickerViewController ()

@end

//TODO: (IMPT) resize this bitch
NSArray *userTypes;
@implementation UserTypePickerViewController

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
    //_realBounds = CGRectMake(0, 0, 320, 320);;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    self.view.superview.bounds = CGRectMake(0, 0, 300,300);
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    userTypes = @[@"Mentee", @"Mentor"];
    return [userTypes objectAtIndex:row];
}



- (IBAction)done:(id)sender
{    
    [self.delegate choseUserType:self withType:[userTypes objectAtIndex:[self.pickerview_userType selectedRowInComponent:0]]];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
