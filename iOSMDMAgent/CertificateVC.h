//
//  ViewController.h
//  iOSMDMAgent
//
//  Created by Dilshan Edirisuriya on 2/5/15.
//  Copyright (c) 2015 WSO2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDKProtocol.h"
#import "MDMConstants.h"

@interface CertificateVC : UIViewController <SDKProtocol, UIAlertViewDelegate>

- (IBAction)installCertificate:(id)sender;

@end


