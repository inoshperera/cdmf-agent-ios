//
//  ViewController.m
//  iOSMDMAgent
//
//  Created by Dilshan Edirisuriya on 2/5/15.
//  Copyright (c) 2015 WSO2. All rights reserved.
//

#import "ViewController.h"
#import "URLUtils.h"
#import "ConnectionUtils.h"
#import "MDMUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbLocationSync.text = [MDMUtils getLocationUpdatedTime];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *autoEnrollmentCompleted = [MDMUtils getPreferance:AUTO_ENROLLMENT_COMPLETED];
    NSString *autoEnrollment = [MDMUtils getPreferance:AUTO_ENROLLMENT];
    if (autoEnrollment != nil && autoEnrollment.length > 0 && [autoEnrollment isEqual:@"YES"] && autoEnrollmentCompleted == nil) {
        [MDMUtils savePreferance:AUTO_ENROLLMENT_COMPLETED value:@"YES"];
        NSString *url = [[URLUtils readEndpoints] objectForKey:AUTO_ENROLLMENT_STATUS_PATH];
        NSString *statusURL =[NSString stringWithFormat:@"%@?status=%@", url, ENROLLMENT_SUCCESS];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:statusURL]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickOnUnRegister:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirm Unregister" message:@"Are you sure you want to unregister this device?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        ConnectionUtils *connectionUtils = [[ConnectionUtils alloc] init];
        connectionUtils.delegate = self;
        [connectionUtils sendUnenrollToServer];
    }
}

- (void)unregisterSuccessful {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MDMUtils setEnrollStatus:UNENROLLED];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:loginViewController animated:TRUE completion:nil];
    });
}

- (void)unregisterFailure:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:UNREGISTER_ERROR message:UNREGISTER_ERROR_MESSAGE delegate:nil cancelButtonTitle:OK_BUTTON_TEXT otherButtonTitles:nil, nil];
        [alertView show];
    });
}
- (IBAction)refresh:(id)sender {
    self.lbLocationSync.text = [MDMUtils getLocationUpdatedTime];
}

@end
