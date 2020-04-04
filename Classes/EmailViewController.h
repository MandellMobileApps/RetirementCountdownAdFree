//
//  EmailViewController.h
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 4/3/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "BaseViewController.h"
#import "ColorsClass.h"
#import <MessageUI/MFMailComposeViewController.h>


@interface EmailViewController : BaseViewController<MFMailComposeViewControllerDelegate,UITextViewDelegate> {



}


@property (nonatomic, retain) IBOutlet UILabel *subjectLabel;
@property (nonatomic, retain) IBOutlet UILabel *toLabel;
@property (nonatomic, retain) IBOutlet UILabel *fromLabel;
@property (nonatomic, retain)  IBOutlet UITextView *bodyTextView;
@property (nonatomic, retain)  IBOutlet UIButton *submitButton;

@end


