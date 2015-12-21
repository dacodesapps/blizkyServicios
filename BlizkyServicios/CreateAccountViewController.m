//
//  CreateAccountViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/21/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "SaludoViewController.h"

@interface CreateAccountViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *serviceButton;
@property (weak, nonatomic) IBOutlet UIButton *staffButton;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"OpenSans-Bold" size:20], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    self.emailTextField.delegate = self;
    
    self.passwordTextField.delegate = self;
    self.phoneNumberTextField.delegate = self;
    
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

- (IBAction)cancelButtonDidPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark - Textfield Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField == self.phoneNumberTextField) {
        int l = (int)textField.text.length + (int)string.length;
        return l < 15 ? YES : NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (IBAction)nextButtonPressed:(id)sender {
    
    BOOL phoneCorrect = self.phoneNumberTextField.text.length >= 6;
    BOOL passwordCorrect = self.passwordTextField.text.length > 0;
    BOOL emailCorrect = [self validEmail:self.emailTextField.text];
        
    if (phoneCorrect && passwordCorrect && emailCorrect) {
        [self performSegueWithIdentifier:@"saludoSegue" sender:self];
    } else {
        NSString * str = @"The information provided is invalid, please check that email address is correct, the password field isn't blank, and the phone number length is between 6 and 15 characters.";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Blizky" message: str preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (BOOL) validEmail:(NSString*) emailString {
    
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
   // NSLog(@"%i",(int) regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"saludoSegue"]) {
        SaludoViewController *saludoVC = (SaludoViewController *) segue.destinationViewController;
        saludoVC.password = self.passwordTextField.text;
        saludoVC.phonenumber = self.phoneNumberTextField.text;
        saludoVC.email = self.emailTextField.text;
    }
}


@end
