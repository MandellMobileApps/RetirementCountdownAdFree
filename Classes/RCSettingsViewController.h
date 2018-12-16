//
//  RCSettings.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkdaysViewController.h"
#import "HolidaysViewController.h"
#import "RetirementDateViewController.h"
#import "WorkhoursViewController.h"
#import "RetirementCountdownAppDelegate.h"
#import "DisplayOptionsViewController.h"
#import "ImagePickerViewController.h"
#import "DaysViewController.h"
#import "HelpViewController.h"
#import "BaseViewController.h"
#import "StatutoryDaysOffViewController.h"

@interface RCSettingsViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {

	NSArray *settings;
	NSArray *settings0;
	NSMutableArray *settingsDetails;
	NSDate *retirementDate;
	NSDate *beginworkhours;
	NSDate *endworkhours;
	NSDateFormatter *dateFormatter;
	NSDateFormatter *dateFormatter2;
	IBOutlet UITableView *tableview;
	int returntosettings;

		
}

@property (nonatomic, retain) NSArray *settings;
@property (nonatomic, retain) NSArray *settings0;
@property (nonatomic, retain) NSMutableArray *settingsDetails;
@property (nonatomic, retain) NSDate *retirementDate;
@property (nonatomic, retain) NSDate *beginworkhours;
@property (nonatomic, retain) NSDate *endworkhours;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSDateFormatter *dateFormatter2;
@property (nonatomic, assign) int returntosettings;
@property (nonatomic, retain) IBOutlet UITableView *tableview;


@end
