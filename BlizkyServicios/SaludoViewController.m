//
//  SaludoViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/21/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "SaludoViewController.h"
#import "CreateProfileTableViewController.h"

@interface SaludoViewController ()

@end

@implementation SaludoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"createProfileSegue" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"createProfileSegue"]) {
        CreateProfileTableViewController *destVC = (CreateProfileTableViewController *) segue.destinationViewController;
        destVC.password = self.password;
        destVC.phonenumber = self.phonenumber;
        destVC.email = self.email;
    }
}


@end
