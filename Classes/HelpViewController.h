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

@class RetirementCountdownAppDelegate;

@interface HelpViewController : BaseViewController <MFMailComposeViewControllerDelegate,UITextViewDelegate> {



}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain)  IBOutlet UITextView *textView;
@property (nonatomic, retain)  IBOutlet UIButton *submitButton;
@property (nonatomic)  BOOL okToSend;
@property (nonatomic)  BOOL removeView;

@end
