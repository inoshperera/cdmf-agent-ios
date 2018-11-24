//
//  AuthenticateViewController.h
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/2/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionUtils.h"

@interface AuthenticateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tenantDomain;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextView *errorText;
@property (retain, nonatomic) ConnectionUtils *connectionUtils;
@property (weak, nonatomic) IBOutlet UIImageView *loadingIV;

- (IBAction)authenticate:(id)sender;

@end
