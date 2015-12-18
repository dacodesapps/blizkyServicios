//
//  InicioViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/18/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "InicioViewController.h"

@interface InicioViewController ()

@end

@implementation InicioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"logInSegue" sender:self];
}
- (IBAction)signUpButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"createAccountSegue" sender:self];
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
