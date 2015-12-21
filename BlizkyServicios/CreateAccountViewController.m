//
//  CreateAccountViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/21/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "CreateAccountViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
