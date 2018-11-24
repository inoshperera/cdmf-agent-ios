//
//  ViewController.m
//  iOSMDMAgent
//
//  Created by Dilshan Edirisuriya on 2/5/15.
//  Copyright (c) 2015 WSO2. All rights reserved.
//

#import "CertificateVC.h"
#import "URLUtils.h"
#import "ConnectionUtils.h"
#import "MDMUtils.h"

@interface CertificateVC ()

@end

@implementation CertificateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup aft  er loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)installCertificate:(id)sender {
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://192.168.1.107:9443/ios-web-agent/enrollment/ios/download-certificate"]];
}
@end

