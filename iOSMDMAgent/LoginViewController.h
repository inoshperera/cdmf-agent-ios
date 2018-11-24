//
//  LoginViewController.h
//  iOSMDMAgent
//
//  Created by Dilshan Edirisuriya on 2/5/15.
//  Copyright (c) 2015 WSO2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDMUtils.h"
#import "MDMConstants.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UITextField *txtServer;

- (IBAction)clickOnRegister:(id)sender;
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;
- (void)enroll;

@end
