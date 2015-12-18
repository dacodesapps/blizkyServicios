//
//  LogInViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/18/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "LogInViewController.h"
#import "AFNetworking.h"

@interface LogInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *serviceButton;
@property (weak, nonatomic) IBOutlet UIButton *staffButton;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"OpenSans-Bold" size:20], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    self.emailTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
    
    [self.serviceButton setBackgroundImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateSelected];
    [self.serviceButton setBackgroundImage:[UIImage imageNamed:@"unselected.png"] forState:UIControlStateNormal];
    [self.staffButton setBackgroundImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateSelected];
    [self.staffButton setBackgroundImage:[UIImage imageNamed:@"unselected.png"] forState:UIControlStateNormal];
    
    self.serviceButton.selected = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Textfield Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - SegmentedControl
- (IBAction)staffButtonPressed:(id)sender {
    if(self.serviceButton.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            self.serviceButton.selected = NO;
            self.staffButton.selected = YES;
            return;
        }];
    }
    self.serviceButton.selected = NO;
    self.staffButton.selected = YES;
}

- (IBAction)serviceButtonPressed:(id)sender {
    if(self.staffButton.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            self.staffButton.selected = NO;
            self.serviceButton.selected = YES;
            return;
        }];
    }
    self.staffButton.selected = NO;
    self.serviceButton.selected = YES;
}


#pragma mark - Api

- (IBAction)logInButtonPressed:(id)sender {
    [self.emailTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"email":self.emailTextfield.text,
                                @"password":self.passwordTextfield.text
                                };
    
    NSString *link = self.serviceButton.selected ? @"http://69.46.5.166:3002/api/Suppliers/login" :@"http://69.46.5.166:3002/api/Staff/login";
    
    [manager POST:link parameters: parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dct = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dct);
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [UIAlertController alertControllerWithTitle:@"blizky" message:@"Success" preferredStyle:UIAlertControllerStyleAlert];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        NSLog(@"Error: %@", [error description]);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [UIAlertController alertControllerWithTitle:@"blizky" message:@"failure" preferredStyle:UIAlertControllerStyleAlert];
    }];

}

- (IBAction)forgotYourPasswordButtonPressed:(id)sender {
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
