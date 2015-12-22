//
//  CreateProfileTableViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/14/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "CreateProfileTableViewController.h"
#import "InicioViewController.h"
#import "AppDelegate.h"

#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "MapTableViewCell.h"
#import "LabelTableViewCell.h"

@interface CreateProfileTableViewController ()<UITableViewDataSource,UITableViewDelegate, UITextViewDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate> {
    NSArray *heights;
    NSString*description;
    UITextView *actTxtView;
    UIImage *imagenSeleccionada;
}

@end

@implementation CreateProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Create Profile";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    imagenSeleccionada = nil;
    
    heights = @[@"200", @"46", @"46", @"198", @"46", @"96", @"26", @"46"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    //[self checkCellsHeigths];
}

-(void)checkCellsHeigths {
    NSMutableArray *array = [NSMutableArray new];
    //float height = 16 + ( (271.0/226.0) * self.view.bounds.size.width *0.35);
    float height = 48 + (self.view.bounds.size.width *0.35);
    [array addObject:@(height)];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    OneTextViewTableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    CGSize s = cell.textView.contentSize;
    CGRect r = CGRectMake(35, 8, self.view.bounds.size.width - 70, s.height);
    cell.textView.frame = r;
    [array addObject:@(s.height)];
    
    path = [NSIndexPath indexPathForRow:2 inSection:0];
    cell = [self.tableView cellForRowAtIndexPath:path];
    s = cell.textView.contentSize;
    r = CGRectMake(35, 8, self.view.bounds.size.width - 70, s.height);
    cell.textView.frame = r;
    [array addObject:@(s.height)];
    
    [array addObject:@(198)];
    
    path = [NSIndexPath indexPathForRow:4 inSection:0];
    cell = [self.tableView cellForRowAtIndexPath:path];
    s = cell.textView.contentSize;
    r = CGRectMake(35, 8, self.view.bounds.size.width - 70, s.height);
    cell.textView.frame = r;
    [array addObject:@(s.height)];
    
    path = [NSIndexPath indexPathForRow:5 inSection:0];
    cell = [self.tableView cellForRowAtIndexPath:path];
    s = cell.textView.contentSize;
    r = CGRectMake(35, 8, self.view.bounds.size.width - 70, s.height);
    cell.textView.frame = r;
    [array addObject:@(s.height)];
    
    [array addObject:@(26)];
    [array addObject:@(42)];
    
    heights = array;
    [self.tableView reloadData];
}

//-(void)dealloc{
//    self.tableView.delegate=nil;
//    self.tableView.dataSource=nil;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier = [NSString stringWithFormat:@"cell%d",(int) indexPath.row + 1];
    //NSString *reuseIdentifier = @"cell1";
    
    if (indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 7) {
        OneButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.button.tag = indexPath.row;
        if (indexPath.row == 0) {
            UIImage *imagen = imagenSeleccionada ? imagenSeleccionada : [UIImage imageNamed:@"AgregarFoto"];
            [cell.button setBackgroundImage:imagen forState:UIControlStateNormal];
            if (imagenSeleccionada) {
                cell.button.layer.cornerRadius = cell.button.frame.size.width / 2.0;
                cell.button.clipsToBounds = YES;
                cell.label.text = @"Edit profile pic.";
            } else {
                cell.label.text = @"Add profile pic.";
            }
        }
        
        [self configureButtons:cell.button];
        
        return cell;
    }
    else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 5) {
        OneTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.textView.tag = indexPath.row;
        cell.textView.scrollEnabled = NO;
        cell.textView.delegate = self;
        
        return cell;
    } else if (indexPath.row == 3) {
        MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        return cell;
    } else {
        LabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    
    // Configure the cell...
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [heights[indexPath.row] floatValue];
}

#pragma mark - Acciones de los botones

-(void)configureButtons:(UIButton *)button{
    switch (button.tag) {
        case 0:
            [button addTarget:self action:@selector(accionBoton1) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            //Picker
            break;
        case 7:
            //Save
            break;
        default:
            break;
    }
}

-(void)accionBoton1 {
    
    if (imagenSeleccionada) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Blizky" message:@""preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Select profile pic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self showPicker];
        }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Delete pic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                imagenSeleccionada = nil;
                [self.tableView reloadData];
        }];
        UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:firstAction];
        [alert addAction:secondAction];
        [alert addAction:thirdAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        [self showPicker];
    }
}

-(void) showPicker {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.navigationBarHidden = YES;
    picker.toolbarHidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    imagenSeleccionada = info[UIImagePickerControllerEditedImage];
    
    int width = imagenSeleccionada.size.width;
    int height = imagenSeleccionada.size.height;
    if(width == height || width-height==24) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.tableView reloadData];
    }
    else {
        NSString * str = @"Error: The image has to be square, please resize the image or pick another one.";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Blizky" message: str preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:textView.tag inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}



-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@""]) {
        if (textView.tag == 1) {
            textView.text = @"  Name (yours or your business)";
        } else if (textView.tag == 2) {
            textView.text = @"  Type in your address";
        } else if (textView.tag == 5) {
            textView.text = @"Description: we'll use this description in your profile and for customers to search for you";
        }
        textView.textColor = [UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0];
    }
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, 800)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    
    float height = newFrame.size.height + 16;
    
    if(height !=  [heights[textView.tag] floatValue]) {
        NSMutableArray *arr = [heights mutableCopy];
        arr[textView.tag] = [NSString stringWithFormat:@"%f", height];
        heights = arr;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)cancelButtonPressed:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InicioViewController *revealViewController = [storyboard instantiateViewControllerWithIdentifier:@"Inicio"];
    appDelegateTemp.window.rootViewController = revealViewController;
    
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
