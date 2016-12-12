//
//  HOME Screen_VC.m
//  IM-HERE
//
//  Created by dhruv patel on 16/06/16.
//  Copyright © 2016 dhruv patel. All rights reserved.
//

#import "HOMEScreen_VC.h"
#import "Map_VC.h"
#import "Profile_VC.h"
#import "Alert_ListVC.h"
#import <SVProgressHUD.h>
#import "List _ViewVC.h"
#import "Notification_VC.h"
#import "immobilize_VC.h"
#import "Track_HistoryVC.h"
#import "Reports_VC.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation HOMEScreen_VC
{
    AppDelegate *myAppDelegate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btnOutltExit.layer.cornerRadius = 10; // this value vary as per your desire
    _btnOutltExit.clipsToBounds = YES;
    
    [self webServiceCall];
    [SVProgressHUD dismiss];
     [[self navigationController] setNavigationBarHidden:NO animated:YES];
    myAppDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
   
    // self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (IBAction)btnExit:(UIButton *)sender {
 
    {
        //show confirmation message to user
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Confirmation"
                                                        message:@"Do you want to exit?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}
    -(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        if (buttonIndex != 0)  // 0 == the cancel button
        {
                UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ViewController"];
            
                UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
                myAppDelegate.window.rootViewController = navigation;

        }
    }



- (IBAction)btnMapView:(UIButton *)sender {
   
}

- (IBAction)btnListView:(UIButton *)sender {
}

- (IBAction)btnAlertLIst:(UIButton *)sender {
  }

- (IBAction)btnNotification:(UIButton *)sender {
    }

- (IBAction)btnImmobilize:(UIButton *)sender {

}

- (IBAction)btnTrackHistory:(UIButton *)sender {
  
    }

- (IBAction)btnProfile:(UIButton *)sender {
  
}

- (IBAction)btnReport:(UIButton *)sender {
}
- (IBAction)btnActionCall:(UIButton *)sender {
    [myAppDelegate directCall];
}
- (IBAction)btnActionContactUs:(UIButton *)sender {
    contactUsProfile_VC *dvc=[self.storyboard instantiateViewControllerWithIdentifier:@"contactUsProfile_VC"];
    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.interactivePopGestureRecognizer.delegate=self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled=NO;
    }
}


#pragma mark-webservice Call

-(void)webServiceCall{
    
    
    NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=22.3038945,70.8021599&destination=23.022505,72.5713621&sensor=false&units=metric"];
    // OR
   // "http://maps.googleapis.com/maps/api/directions/json?origin=Ahmedabad&destination=surat&sensor=true&alternatives=true"
    // OR
     // "http://maps.googleapis.com/maps/api/directions/json?origin=@%&destination=@%&sensor=true&alternatives=true"startingPoint.Text,EnddingPoint.Text,
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Url: %@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSArray *routes = [result objectForKey:@"routes"];
        
        NSDictionary *firstRoute = [routes objectAtIndex:0];
        
        NSDictionary *leg =  [[firstRoute objectForKey:@"legs"] objectAtIndex:0];
        
        NSDictionary *distance = [leg objectForKey:@"distance"] ;
        NSDictionary *duration = [leg objectForKey:@"duration"] ;
        NSDictionary *StartLocation = [leg objectForKey:@"start_location"] ;
        NSDictionary *EndLocation = [leg objectForKey:@"end_location"] ;
        
       
        
        NSString *DistanceValue=[distance objectForKey:@"text"];
        NSString *DurationValue=[duration objectForKey:@"text"];
        NSString *StartLat=[StartLocation objectForKey:@"lat"];
        NSString *StartLng=[StartLocation objectForKey:@"lng"];
        NSString *EndLat=[EndLocation objectForKey:@"lat"];
        NSString *EndLng=[EndLocation objectForKey:@"lng"];
        
        NSLog(@"\nDistance :%@ \nDuration : %@ \nStartLat: %@ \nStartLng : %@ \nEndLat : %@ \nEndLng: %@",DistanceValue,DurationValue,StartLat,StartLng,EndLat,EndLng);
    }];
    
}
/*
 NSString *api = @"AIzaSyAtWwoW85HqgagmSXDh3H3SRB3ZByXXSbo";
 NSMutableString *loginrequest=[NSMutableString stringWithFormat:@"http://maps.google.com/maps/api/directions/xml?origin=Toronto&destination=Montreal&key=%@",api];
 
 // https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=YOUR_API_KEY
 
 
 NSURLSessionConfiguration* sessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession* session=[NSURLSession sessionWithConfiguration:sessionConfiguration];
 NSURL *requestURL=[NSURL URLWithString:loginrequest];
 
 NSURLSessionDataTask* sessionTask=[session dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 
 if(data)
 {
 _arrData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
 NSLog(@"dic is :%@",_arrData);
 
 }
 
 else{
 
 NSLog(@"Error parsing JSON.");
 UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NULL message:@"Server Error" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
 
 [alert show];
 [SVProgressHUD dismiss];
 
 
 }
 
 }];
 [sessionTask resume];
 

 */
@end
