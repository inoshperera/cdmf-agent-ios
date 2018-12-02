//
//  AutoEnrollmentViewController.m
//  iOSMDMAgent
//
//  Created by Inosh Perera on 12/2/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import "AutoEnrollmentViewController.h"
#import "MDMUtils.h"
#import "URLUtils.h"
#import "ConnectionUtils.h"
#import "InstallProfileViewController.h"

@interface AutoEnrollmentViewController ()

@end

@implementation AutoEnrollmentViewController
@synthesize error;
@synthesize progressImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *animationArray = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"loading1.gif"],
                               [UIImage imageNamed:@"loading2.gif"],
                               [UIImage imageNamed:@"loading3.gif"],
                               [UIImage imageNamed:@"loading4.gif"],
                               nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startAutoEnrollment:)
                                                 name:@"startAutoEnrollment" object:nil];
    progressImage.animationImages = animationArray;
    progressImage.animationDuration = 0.5;
    [progressImage startAnimating];
}

- (void)authenticate {
    NSString *username = [MDMUtils getPreferance:USERNAME];
    NSString *password = [MDMUtils getPreferance:PASSWORD];
    NSString *tenantDomain = [MDMUtils getPreferance:TENANT_NAME];
    
    if (username != nil && username.length > 0 && ![username isEqual:@""]) {
        if (password != nil && password.length > 0 && ![password isEqual:@""]) {
            _connectionUtils = [[ConnectionUtils alloc] init];
            if (tenantDomain == nil || tenantDomain.length > 0 || [tenantDomain isEqual:@""]) {
                tenantDomain = @"carbon.super";
            }
            
            [_connectionUtils authenticate:tenantDomain username:username password:password completion:^(BOOL success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        [MDMUtils savePreferance:PASSWORD value:@""];
                        /*
                         There is an OS level bug where whatever the real location authorisation level is;
                         didChangeAuthorizationStatus is called before didChangeAuthorizationStatus and causes
                         not_determined to be returned. Only workaround for this would be to start a timer and poll
                         the API to check if the user has given the permission.
                         https://github.com/dpa99c/cordova-diagnostic-plugin/issues/123
                         */
                        [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(checkLocation:)
                                                       userInfo:nil
                                                        repeats:YES];

                    } else {
                        error.text = @"Authentication Failed!";
                        NSString *url = [[URLUtils readEndpoints] objectForKey:AUTO_ENROLLMENT_STATUS_PATH];
                        NSString *statusURL =[NSString stringWithFormat:@"%@?status=%@", url, AUTHENTICATION_FAIL];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:statusURL]];
                    }
                });
            }];
        } else {
            error.text = @"Password cannot be empty";
            NSString *url = [[URLUtils readEndpoints] objectForKey:AUTO_ENROLLMENT_STATUS_PATH];
            NSString *statusURL =[NSString stringWithFormat:@"%@?status=%@", url, EMPTY_PASSWORD];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:statusURL]];
        }
    } else {
        error.text = @"Username cannot be empty";
        NSString *url = [[URLUtils readEndpoints] objectForKey:AUTO_ENROLLMENT_STATUS_PATH];
        NSString *statusURL =[NSString stringWithFormat:@"%@?status=%@", url, EMPTY_USERNAME];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:statusURL]];
    }
}

-(void) checkLocation:(NSTimer*)timer  {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                InstallProfileViewController *installProfileVC = (InstallProfileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"installProfileVC"];
                                [self presentViewController:installProfileVC animated:YES completion:nil];
        [timer invalidate];
        timer = nil;
    }
}

- (void)startAutoEnrollment:(NSNotification *)note {
    [self authenticate];
}

@end
