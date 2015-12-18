//
//  CreateProfileTableViewController.m
//  BlizkyServicios
//
//  Created by Pablo on 12/14/15.
//  Copyright © 2015 DaCodes. All rights reserved.
//

#import "CreateProfileTableViewController.h"

#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "MapTableViewCell.h"
#import "LabelTableViewCell.h"

@interface CreateProfileTableViewController ()<UITableViewDataSource,UITableViewDelegate, UITextViewDelegate> {
    NSArray *heights;
    NSString*description;
    UITextView *actTxtView;
}

@end

@implementation CreateProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hla";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    float height = 16 + ( (271.0/226.0) * self.view.bounds.size.width *0.35);
    
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
    
    if (indexPath.row == 0 || indexPath.row == 7) {
        OneButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
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

#pragma mark - TextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    
//    CGRect f = self.tableView.frame;
//    f.origin = CGPointZero;
//    f.size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height- 216);
//    self.tableView.frame = f;
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:textView.tag inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

//- (void)keyboardWillShow:(NSNotification*)notification {
//    NSDictionary *info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    CGFloat deltaHeight = kbSize.height - _currentKeyboardHeight;
//    // Write code to adjust views accordingly using deltaHeight
//    
//    float offset = self.tableView.contentSize.height - self.view.bounds.size.height - deltaHeight;
//    if (actTxtView.tag == 1) {
//        offset = 0;
//    }
//    
//    CGRect f = self.tableView.frame;
//    f.origin = CGPointZero;
//    f.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + - abs((int)offset));
//    self.tableView.frame = f;
//    
//    _currentKeyboardHeight = kbSize.height;
//}
//
//- (void)keyboardWillHide:(NSNotification*)notification {
//    NSDictionary *info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    // Write code to adjust views accordingly using kbSize.height
//    
//
//    
//    CGRect f = self.tableView.frame;
//    f.origin = CGPointMake(0, 0);
//    f.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
//    self.tableView.frame = f;
//    
//    _currentKeyboardHeight = 0.0f;
//}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
//    [UIView animateWithDuration:0.22 animations:^{
//        CGRect f = self.tableView.frame;
//        f.origin = CGPointMake(0, 0);
//        self.tableView.frame = f;
//    }];
    
    
//    CGRect f = self.tableView.frame;
//    f.origin = CGPointZero;
//    f.size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
//    self.tableView.frame = f;
    
    if ([textView.text isEqualToString:@""]) {
        if (textView.tag == 1) {
            textView.text = @"  Name (yours or your business)";
        } else if (textView.tag == 2) {
            textView.text = @"  Type in your address";
        } else if (textView.tag == 4) {
            textView.text = @"   Type in your kind of service(personal trainer, restourant...)";
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
