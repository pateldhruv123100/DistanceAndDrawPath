//
//  HOME Screen_VC.h
//  IM-HERE
//
//  Created by dhruv patel on 16/06/16.
//  Copyright © 2016 dhruv patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Map_VC.h"
#import "contactUsProfile_VC.h"
#import <QuartzCore/QuartzCore.h>
@interface HOMEScreen_VC : UIViewController<UINavigationBarDelegate,UIGestureRecognizerDelegate>
- (IBAction)btnExit:(UIButton *)sender;

- (IBAction)btnMapView:(UIButton *)sender;
- (IBAction)btnListView:(UIButton *)sender;
- (IBAction)btnAlertLIst:(UIButton *)sender;
- (IBAction)btnNotification:(UIButton *)sender;
- (IBAction)btnImmobilize:(UIButton *)sender;
- (IBAction)btnTrackHistory:(UIButton *)sender;
- (IBAction)btnProfile:(UIButton *)sender;
- (IBAction)btnReport:(UIButton *)sender;
- (IBAction)btnActionContactUs:(UIButton *)sender;
- (IBAction)btnActionCall:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOutltExit;
@property(strong,nonatomic)NSDictionary* customerDetails;
@property(nonatomic, readonly) UIGestureRecognizer *interactivePopGestureRecognizer;
@property (nonatomic, strong) NSArray *arrData;
@end
