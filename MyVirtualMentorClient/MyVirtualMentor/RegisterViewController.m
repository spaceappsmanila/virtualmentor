//
//  RegisterViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserTypePickerViewController.h"
#import "Member.h"
#import "AppDelegate.h"

@interface RegisterViewController ()

@end



@implementation RegisterViewController

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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showUserTypePicker"])
    {
        //[[segue destinationViewController] setDelegate:self];
        UserTypePickerViewController *utvc = [segue destinationViewController];
        utvc.delegate =self;
        //utvc setModalPresentationStyle:UIModalPresentationFormSheet];
        //utvc.view.superview.bounds = CGRectMake(0, 0, 320, 320);
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userType:(id)sender {
}

- (IBAction)pressedRegister:(id)sender
{
    /*
    //Save in Core Data
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];    
    Member *newMember = (Member *)[NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:delegate.managedObjectContext];    
    newMember.firstName = self.txtfld_firstName.text;
    newMember.lastName = self.txtfld_lastName.text;
    newMember.username = self.txtfld_username.text;
    newMember.password = self.txtfld_password.text;
    newMember.memberType = self.txtfld_password.text;
    
    NSLog(@"%@", newMember.username);
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"loggedin"];
    */

    
    NSString *membershipTypeString = [[NSString alloc]init];
    
    int membershipType = 0;
    
    if ([self.btn_type.currentTitle isEqualToString:@"Admin"])
    {
        membershipType = 1;
    }
    else if ([self.btn_type.currentTitle isEqualToString:@"Mentor"])
    {
        membershipType = 2;
        membershipTypeString = @"mentor";
    }

    else if ([self.btn_type.currentTitle isEqualToString:@"Mentee"])
    {
        membershipType = 3;
        membershipTypeString = @"mentee";
    }
   
    
    
    NSString *param = [NSString stringWithFormat:@"member[firstname]=%@&member[lastname]=%@&member[email]=%@&member[password]=%@&member[cpassword]=%@&member[membership]=%d", self.txtfld_firstName.text, self.txtfld_lastName.text, self.txtfld_username.text,self.txtfld_password.text, self.txtfld_password.text, membershipType];
    
    NSData *data=[param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength=[NSString stringWithFormat:@"%d",[data length]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@index.php/register/%@",kURL, membershipTypeString]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    
    
    [self.delegate successfulRegistration:self];
}

//FOR DEVELOPMENT PURPOSES
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{    
    NSString *response=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];    
    NSLog(@"response %@",response);     
}



- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)choseUserType:(UserTypePickerViewController *)controller withType:(NSString *)userType
{
    
    [self.btn_type setTitle:userType forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
