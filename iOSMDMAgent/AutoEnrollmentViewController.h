//
//  AutoEnrollmentViewController.h
//  iOSMDMAgent
//
//  Created by Inosh Perera on 12/2/18.
//  Copyright © 2018 WSO2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutoEnrollmentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *error;
@property (retain, nonatomic) ConnectionUtils *connectionUtils;
@property (weak, nonatomic) IBOutlet UIImageView *progressImage;
- (void)startAutoEnrollment:(NSNotification *)note;
-(void) checkLocation:(NSTimer*)timer;

@end

NS_ASSUME_NONNULL_END
