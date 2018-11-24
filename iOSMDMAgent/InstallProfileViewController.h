//
//  InstallProfileViewController.h
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/6/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionUtils.h"
#import "AppDelegate.h"

@interface InstallProfileViewController : UIViewController
- (IBAction)okProfile:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *progressProfile;
@property (weak, nonatomic) IBOutlet UITextView *textProfile;
@property (retain, nonatomic) ConnectionUtils *connectionUtils;

- (void)checkEnrollment;

@end
