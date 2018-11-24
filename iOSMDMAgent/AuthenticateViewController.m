//
//  AuthenticateViewController.m
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/2/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import "AuthenticateViewController.h"
#import "ConnectionUtils.h"
#import "LicenseViewController.h"
#import "URLUtils.h"
#import "MDMUtils.h"

@interface AuthenticateViewController ()

@end

@implementation AuthenticateViewController

@synthesize tenantDomain;
@synthesize username;
@synthesize password;
@synthesize errorText;
@synthesize loadingIV;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)authenticate:(id)sender {
    NSArray *animationArray = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"loading1.gif"],
                               [UIImage imageNamed:@"loading2.gif"],
                               [UIImage imageNamed:@"loading3.gif"],
                               [UIImage imageNamed:@"loading4.gif"],
                               nil];
    loadingIV.animationImages = animationArray;
    loadingIV.animationDuration = 0.5;
    [loadingIV startAnimating];
    if (username.text != nil || username.text.length > 0 || ![username.text isEqual:@""]) {
        if (password.text != nil || password.text.length > 0 || ![password.text isEqual:@""]) {
            NSString *tenant = tenantDomain.text;
            _connectionUtils = [[ConnectionUtils alloc] init];
            if (tenantDomain.text != nil || tenantDomain.text.length > 0 || ![tenantDomain.text isEqual:@""]) {
                tenant = @"carbon.super";
            }
            
            [_connectionUtils authenticate:tenant username:username.text password:password.text completion:^(BOOL success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        [MDMUtils savePreferance:USERNAME value:username.text];
                        [MDMUtils savePreferance:TENANT_DOMAIN value:tenant];
                        [_connectionUtils getLicense:^(BOOL success) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (success) {
                                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    LicenseViewController *licenseVC = (LicenseViewController *)[storyboard instantiateViewControllerWithIdentifier:@"licenseVC"];
                                    [self presentViewController:licenseVC animated:YES completion:nil];
                                } else {
                                    errorText.text = @"Authentication Failed. Could not get license text!";
                                    [loadingIV stopAnimating];
                                }
                            });
                        }];
                    } else {
                        errorText.text = @"Authentication Failed!";
                        [loadingIV stopAnimating];
                    }
                });
            }];
        } else {
            errorText.text = @"Password cannot be empty";
        }
    } else {
        errorText.text = @"Username cannot be empty";
    }
}

@end
