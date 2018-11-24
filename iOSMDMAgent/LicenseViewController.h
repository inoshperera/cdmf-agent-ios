//
//  LicenseViewController.h
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/3/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LicenseViewController : UIViewController
- (IBAction)acceptLicense:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rejectLicense;
- (IBAction)cancelLicense:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *licenseText;

@end
