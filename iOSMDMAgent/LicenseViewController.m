//
//  LicenseViewController.m
//  iOSMDMAgent
//
//  Created by Inosh Perera on 11/3/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import "LicenseViewController.h"
#import "MDMUtils.h"
#import "URLUtils.h"
#import "LoginViewController.h"

@interface LicenseViewController ()

@end

@implementation LicenseViewController
@synthesize licenseText;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *licenseHtml = [MDMUtils getPreferance:LICENSE_TEXT];
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [licenseHtml dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    licenseText.attributedText = attributedString;
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

- (IBAction)acceptLicense:(id)sender {
    
}
- (IBAction)cancelLicense:(id)sender {
    [MDMUtils savePreferance:USERNAME value:nil];
    [MDMUtils savePreferance:TENANT_DOMAIN value:nil];
    [MDMUtils savePreferance:ACCESS_TOKEN value:nil];
    [MDMUtils savePreferance:REFRESH_TOKEN value:nil];
    [MDMUtils savePreferance:CLIENT_CREDENTIALS value:nil];
    [MDMUtils savePreferance:CHALLANGE_TOKEN value:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [self presentViewController:loginViewController animated:YES completion:nil];
}
@end
