//
//  InstallProfileViewController.m
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/6/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import "InstallProfileViewController.h"
#import "ViewController.h"
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
                                             selector:@selector(enrollmentComplete:)
                                                 name:@"enrollmentComplete" object:nil];
    NSArray *animationArray = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"loading1.gif"],
                               [UIImage imageNamed:@"loading2.gif"],
                               [UIImage imageNamed:@"loading3.gif"],
                               [UIImage imageNamed:@"loading4.gif"],
                               nil];
    progressProfile.animationImages = animationArray;
    progressProfile.animationDuration = 0.5;
    [progressProfile startAnimating];
    textProfile.text = @"Waiting for installation process completion.";
    [self autoEnrollmentFlow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)autoEnrollmentFlow {
    NSString *autoEnrollment = [MDMUtils getPreferance:AUTO_ENROLLMENT];
    if (autoEnrollment != nil && autoEnrollment.length > 0 && [autoEnrollment isEqual:@"YES"]) {
        [MDMUtils savePreferance:AUTO_ENROLLMENT_COMPLETED value:nil];
        NSString *url = [URLUtils getEnrollURL:[MDMUtils getPreferance:TENANT_DOMAIN] username:[MDMUtils getPreferance:CHALLANGE_TOKEN]];
        NSLog(@"autoEnrollmentFlow url %@", url);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

- (void)enrollmentComplete:(NSNotification *)note {
    NSLog(@"checkEnrollment");
    if (self.view.window != nil) {
        _connectionUtils = [[ConnectionUtils alloc] init];
        [_connectionUtils isEnrolled:^(BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    NSLog(@"checkEnrollment success");
                    [MDMUtils setEnrollStatus:ENROLLED];
                    AppDelegate* deligate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
                    [deligate registerForPushToken];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        ViewController *authVC = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"viewController"];
                        [self presentViewController:authVC animated:YES completion:nil];
                        
                    });
                } else {
                    NSLog(@"checkEnrollment fail");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enrollment not complete"
                                                                        message:@"You have not finished the "
                                                                        "enrollment steps in Safari or Enrollment has failed"
                                                                        " Do you want to restart enrollment or wait at this stage for you"
                                                                        "  to complete steps in Safari"
                                                                       delegate:self
                                                              cancelButtonTitle:@"Retry"
                                                              otherButtonTitles:@"I'll go to Safari", nil];
                        [alert show];
                }
            });
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *autoEnrollment = [MDMUtils getPreferance:AUTO_ENROLLMENT];
    switch(buttonIndex) {
        case 0:
            if (autoEnrollment != nil || autoEnrollment.length > 0 || [autoEnrollment isEqual:@"YES"]) {
                [self clearPrefs];
                NSString *url = [[URLUtils readEndpoints] objectForKey:AUTO_ENROLLMENT_STATUS_PATH];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            } else {
                [self restart];
            }
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            break;
        case 1:
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            break;
    }
}

- (void)restart {
    [self clearPrefs];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void)clearPrefs {
    [MDMUtils savePreferance:USERNAME value:nil];
    [MDMUtils savePreferance:TENANT_DOMAIN value:nil];
    [MDMUtils savePreferance:ACCESS_TOKEN value:nil];
    [MDMUtils savePreferance:REFRESH_TOKEN value:nil];
    [MDMUtils savePreferance:CLIENT_CREDENTIALS value:nil];
    [MDMUtils savePreferance:CHALLANGE_TOKEN value:nil];
    [MDMUtils savePreferance:AUTO_ENROLLMENT_COMPLETED value:nil];
    [MDMUtils setEnrollStatus:UNENROLLED];
}

@end
