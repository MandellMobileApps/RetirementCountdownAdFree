//
//  HolidaysViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/3/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddHolidayViewController.h"
#import "BaseViewController.h"


@interface HolidaysViewController : BaseViewController {

	NSMutableArray *holidaynames;
	NSMutableArray *holidaymonth;
	NSMutableArray *holidayday;
	NSMutableArray *holidayweekday;
	NSMutableArray *holidayordinal;
	NSMutableArray *holidayused;
	NSMutableArray *holidayList;
	IBOutlet UITableView *holidayTableView;
	int changed;
	
}

@property (nonatomic, retain) NSMutableArray *holidaynames;
@property (nonatomic, retain) NSMutableArray *holidaymonth;
@property (nonatomic, retain) NSMutableArray *holidayday;
@property (nonatomic, retain) NSMutableArray *holidayweekday;
@property (nonatomic, retain) NSMutableArray *holidayordinal;
@property (nonatomic, retain) NSMutableArray *holidayused;
@property (nonatomic, retain) NSMutableArray *holidayList;
@property (nonatomic, retain) IBOutlet UITableView *holidayTableView;


@property (nonatomic, assign) int changed;


@end
