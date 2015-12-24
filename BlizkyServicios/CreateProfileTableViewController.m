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
#import "MapViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "MapTableViewCell.h"
#import "LabelTableViewCell.h"

@interface CreateProfileTableViewController ()<UITableViewDataSource,UITableViewDelegate, UITextViewDelegate,UIImagePickerControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate, MapViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    NSArray *heights, *categories, *textViews, *categoriesDictionaries;
    NSString *description, *categoriaSeleccionada;
    UITextView *actTxtView, *textView1;
    UIImage *imagenSeleccionada;
    MKMapView *mapView;
    MKPointAnnotation *mapAnnotationPin;
    UIPickerView *pickerView;
    BOOL alreadyLongPressed, descargando;
}

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation CreateProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Create Profile";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    imagenSeleccionada = nil;
    
    heights = @[@"200", @"46", @"46", @"198", @"46", @"96", @"26", @"46"];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCategories];
    alreadyLongPressed = NO;
    descargando = NO;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponder)];
    [self.view addGestureRecognizer:recognizer];
}

-(void)resignTextViewResponder {
    NSLog(@"tap Gesture");
    [actTxtView resignFirstResponder];
}

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
    else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4  || indexPath.row == 5) {
        OneTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        if(!textViews ) {
            textViews = [NSArray new];
        }
        NSMutableArray *arr = [textViews mutableCopy];
        
        
        cell.textView.tag = indexPath.row;
        cell.textView.scrollEnabled = NO;
        cell.textView.delegate = self;
        cell.textView.returnKeyType = UIReturnKeyDone;
        
        if (indexPath.row == 4) {
            if (categoriaSeleccionada) {
                cell.textView.text = categoriaSeleccionada;
            }
            textView1 = cell.textView;
            textView1.userInteractionEnabled = !descargando;
            pickerView = [[UIPickerView alloc] init];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
            pickerView.showsSelectionIndicator=YES;
            cell.textView.inputView  = pickerView;
            
        }
        
        [arr addObject:cell.textView];
        textViews = arr;
        
        return cell;
    } else if (indexPath.row == 3) {
        MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        mapView = cell.mapView;
        mapView.showsUserLocation = YES;
        [cell.goToCurrentLocation addTarget:self action:@selector(zoomToUserLocation:) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
        [mapView addGestureRecognizer:longPressGesture];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureOnMap:)];
        [mapView addGestureRecognizer:tapGesture];
        if (mapAnnotationPin) {
            if (mapAnnotationPin.coordinate.longitude == mapView.userLocation.coordinate.longitude && mapAnnotationPin.coordinate.latitude == mapView.userLocation.coordinate.latitude) {
                mapView.showsUserLocation = NO;
            } else {
                mapView.showsUserLocation = YES;
            }
            [mapView showAnnotations:@[mapAnnotationPin] animated:YES];
            
        }
        
        return cell;
    } else {
        LabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    
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
        case 7:
        [button addTarget:self action:@selector(accionBoton2) forControlEvents:UIControlEventTouchUpInside];
        break;
        default:
        break;
    }
}

-(void)accionBoton1 {
    if (imagenSeleccionada) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Blizky" message:@""preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Select profile pic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self showImagePicker];
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
        [self showImagePicker];
    }
}

-(void) showImagePicker {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = (id) self;
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

-(void)accionBoton2 {
    
    NSString *serviceName, *address, *descriptionStr, *categoryService_id;
    
    for (UITextView *txtView in textViews) {
        switch (txtView.tag) {
            case 1:
            serviceName = txtView.text;
            break;
            case 2:
            address = txtView.text;
            break;
            case 4:
            for (NSDictionary *dct in categoriesDictionaries) {
                if ([txtView.text isEqualToString:dct[@"name"]]) {
                    categoryService_id = dct[@"id"];
                }
            }
            break;
            case 5:
            descriptionStr = txtView.text;
            break;
            
            default:
            break;
        }
    }
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *link = @"http://69.46.5.166:3002/api/CategoryServices";
    
    NSDictionary *params = @{@"phone": self.phonenumber,
                             };
    
    [manager POST:link parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        
        NSLog(@"Error: %@", [error description]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        
    }];
    
    
}

#pragma mark - MapKit

-(void)zoomToUserLocation:(UIButton *) sender {
    
    if (!mapAnnotationPin) {
        mapAnnotationPin = [MKPointAnnotation new];
    }
    
    mapAnnotationPin.coordinate = mapView.userLocation.coordinate;
    [mapView showAnnotations:@[mapAnnotationPin] animated:YES];
    mapView.showsUserLocation = NO;
    
    //    MKCoordinateRegion region;
    //    region.center = mapView.userLocation.coordinate;
    //    //Adjust span as you like
    //    MKCoordinateSpan span;
    //    span.latitudeDelta  = 1;
    //    span.longitudeDelta = 1;
    //    region.span = span;
    //
    //    [mapView setRegion:region animated:YES];
}

-(void)handleLongPressGesture:(UIGestureRecognizer *) sender {
    if (!alreadyLongPressed) {
        alreadyLongPressed = YES;
        [self performSegueWithIdentifier:@"showMapVC" sender:self];
    }
}

-(void)handleTapGestureOnMap:(UIGestureRecognizer *) sender {
    CGPoint point = [sender locationInView:mapView];
    CLLocationCoordinate2D locCoord = [mapView convertPoint:point toCoordinateFromView:mapView];
    if (!mapAnnotationPin) {
        mapAnnotationPin = [MKPointAnnotation new];
    }
    mapAnnotationPin.coordinate = locCoord;
    
    // [mapView showAnnotations:@[mapAnnotationPin] animated:YES];
    [mapView addAnnotation:mapAnnotationPin];
    mapView.showsUserLocation = YES;
}

#pragma mark - TextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView {
    actTxtView = textView;
    if (textView.tag != 4 || categories) {
        textView.text = @"";
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:textView.tag inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        if (!descargando) {
            [self getCategories];
        }
        [textView resignFirstResponder];
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showMapVC"]) {
        MapViewController *mapVC = (MapViewController *) segue.destinationViewController;
        mapVC.annotationPin = mapAnnotationPin;
        mapVC.delegate = self;
    }
}

#pragma mark - MapView Delegate

-(void)goingBack:(MKPointAnnotation *)pin {
    if (pin) {
        mapAnnotationPin = pin;
        if (pin.coordinate.longitude == mapView.userLocation.coordinate.longitude && pin.coordinate.latitude == mapView.userLocation.coordinate.latitude) {
            mapView.showsUserLocation = NO;
        } else {
            mapView.showsUserLocation = YES;
        }
        [mapView showAnnotations:@[pin] animated:YES];
        
    }
}

#pragma mark - Conection

-(void)getCategories {
    descargando = YES;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *link = @"http://69.46.5.166:3002/api/CategoryServices";
    
    [manager GET:link parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *array = [NSMutableArray new];
        for(NSDictionary *dct in arr) {
            [array addObject:dct[@"name"]];
        }
        categoriesDictionaries = arr;
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        categories = array;
        descargando = NO;
        [pickerView reloadAllComponents];
        [pickerView selectRow:0 inComponent:0 animated:YES];
        if (textView1) {
            textView1.userInteractionEnabled = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        
        NSLog(@"Error: %@", [error description]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        descargando = NO;
    }];
    
    
}

#pragma mark - PickerView

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    categoriaSeleccionada = categories[row];
    [self.tableView reloadData];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return categories? 1 : 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return categories[row];
}



@end
