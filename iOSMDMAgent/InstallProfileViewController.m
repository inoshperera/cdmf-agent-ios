//
//  InstallProfileViewController.m
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/6/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import "InstallProfileViewController.h"
#import "URLUtils.h"
#import "MDMUtils.h"
#import "ConnectionUtils.h"
#import "AppDelegate.h"

@interface InstallProfileViewController ()

@end

@implementation InstallProfileViewController
@synthesize progressProfile;
@synthesize textProfile;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkEnrollment)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkEnrollment {
    NSLog(@"checkEnrollment");
    _connectionUtils = [[ConnectionUtils alloc] init];
    [_connectionUtils isEnrolled:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                AppDelegate* deligate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
                [deligate registerForPushToken];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *unregisterViewController = [storyboard instantiateViewControllerWithIdentifier:@"viewController"];
                UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
                unregisterViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                [top presentViewController:unregisterViewController animated:NO completion:nil];
            } else {
                
            }
        });
    }];
}

- (IBAction)okProfile:(id)sender {
    NSArray *animationArray = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"loading1.gif"],
                               [UIImage imageNamed:@"loading2.gif"],
                               [UIImage imageNamed:@"loading3.gif"],
                               [UIImage imageNamed:@"loading4.gif"],
                               nil];
    progressProfile.animationImages = animationArray;
    progressProfile.animationDuration = 0.5;
    [progressProfile startAnimating];
    NSString *joinString=[URLUtils getEnrollURL:[MDMUtils getPreferance:TENANT_DOMAIN] username:[MDMUtils getPreferance:CHALLANGE_TOKEN] ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:joinString]];
    NSLog(@"acceptLicense:url: %@", joinString);
    textProfile.text = @"Waiting for installation completion is notified";
}
@end
