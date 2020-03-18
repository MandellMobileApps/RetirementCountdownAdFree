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


	
}

//@property (nonatomic, retain) NSMutableArray *holidaynames;
//@property (nonatomic, retain) NSMutableArray *holidaymonth;
//@property (nonatomic, retain) NSMutableArray *holidayday;
//@property (nonatomic, retain) NSMutableArray *holidayweekday;
//@property (nonatomic, retain) NSMutableArray *holidayordinal;
//@property (nonatomic, retain) NSMutableArray *holidayused;
@property (nonatomic, retain) NSArray *holidayListStandard;
@property (nonatomic, retain) NSMutableArray *holidayListCustom;
@property (nonatomic, retain) IBOutlet UITableView *holidayTableView;


@property (nonatomic, assign) NSInteger changed;

-(void)refreshHolidayList;

@end
