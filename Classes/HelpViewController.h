//
//  HelpViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/24/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsClass.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "BaseViewController.h"


@interface HelpViewController : BaseViewController <MFMailComposeViewControllerDelegate> {

IBOutlet UILabel *textLabel;


}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;

-(void) sendEmail;

@end
