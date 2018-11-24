//
//  CAViewController.h
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/2/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAViewController : UIViewController

- (IBAction)caCertInstall:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextClick:(id)sender;
- (void)someaction ;

@end
