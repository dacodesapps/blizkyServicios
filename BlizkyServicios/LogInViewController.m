//
//  LogInViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/18/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "LogInViewController.h"

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
    self.emailTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
    
    [self.serviceButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [self.serviceButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButtonPressed:(id)sender {
}

- (IBAction)forgotYourPasswordButtonPressed:(id)sender {
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
