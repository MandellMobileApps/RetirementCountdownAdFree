//
//  StatutoryDaysOffViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/4/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface StatutoryDaysOffViewController : BaseViewController {

	IBOutlet UITextField  *thisYear;
	IBOutlet UITextField  *allYears;
	IBOutlet UITextField  *retirementYear;
    IBOutlet UILabel  *singleYearLabel;
}


@property(nonatomic,retain) IBOutlet UITextField  *thisYear;
@property(nonatomic,retain) IBOutlet UITextField  *allYears;
@property(nonatomic,retain) IBOutlet UITextField  *retirementYear;
@property(nonatomic,retain) IBOutlet UILabel  *singleYearLabel;

-(IBAction) dismissKeyboard:(id)sender;
-(BOOL)hideSingleYearMessage;
@end
