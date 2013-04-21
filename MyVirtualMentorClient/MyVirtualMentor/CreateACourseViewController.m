//
//  CreateLessonPlanViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/20/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "CreateACourseViewController.h"

@interface CreateACourseViewController ()

@end

@implementation CreateACourseViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveLessonPlan:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lessonPlanString = [defaults objectForKey:@"lessonPlan"];
   
    NSString *param = [NSString stringWithFormat:@"json={\"description\":\"%@\", \"name\":\"%@\", \"owner\":\"3\", %@ }", self.txtVw_courseDescription.text, self.txtFld_courseName.text, lessonPlanString];
    
    
    
    
    
    
    NSLog(@"%@",param);
    NSData *data=[param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength=[NSString stringWithFormat:@"%d",[data length]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mentor/create/course",kURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];

    self.txtFld_courseName.text = @"";
    self.txtVw_courseDescription.text = @"";
    
}



//FOR DEVELOPMENT PURPOSES
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    NSString *response=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"response %@",response);
}


#pragma mark - Create a course methods
-(void)createdALessonPlan:(LessonPlanViewController *)controller
{
    
    // [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCreateWeeklyLessonPlan"]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        //CreateLessonPlanViewController *clpvc = [storyboard instantiateViewControllerWithIdentifier:@"CreateLessonPlanViewController"];
        UINavigationController *nav=[segue destinationViewController];
        
        LessonPlanViewController *clpvc = [[nav viewControllers] objectAtIndex:0];
        clpvc.delegate = self;        
    }
}


@end
