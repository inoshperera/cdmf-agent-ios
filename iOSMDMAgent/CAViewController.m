//
//  CAViewController.m
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/2/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import "CAViewController.h"
#import "AuthenticateViewController.h"
#import "URLUtils.h"

@interface CAViewController ()

@end

@implementation CAViewController
@synthesize nextButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nextButton setHidden:NO];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}

- (void)someaction {
//    [super viewDidLoad];
//    [self.nextButton setHidden:NO];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)caCertInstall:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[URLUtils getCaDownloadURL]]];
    [self.nextButton setHidden:NO];
}


- (IBAction)nextClick:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    AuthenticateViewController *authVC = (AuthenticateViewController *)[storyboard instantiateViewControllerWithIdentifier:@"authenticateController"];
//    [self presentViewController:authVC animated:YES completion:nil];
}
@end
