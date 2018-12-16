//
//  SelectHolidayDateViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/16/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"


@interface SelectHolidayDateViewController : BaseTableViewController {

	NSString *title;
	NSString *tableToLookup;
	NSUInteger valueSelected;
	NSUInteger locationInList;
	
	NSMutableString *holidayName;
	NSUInteger holidayMonth;
	NSUInteger holidayDay;
	NSUInteger holidayWeekday;
	NSUInteger holidayOrdinalWeekday;
	BOOL cancelledSave;

}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *tableToLookup;
@property (nonatomic, assign) NSUInteger valueSelected;
@property (nonatomic, assign) NSUInteger locationInList;

@property (nonatomic, retain) NSMutableString *holidayName;
@property (nonatomic, assign) NSUInteger holidayMonth;
@property (nonatomic, assign) NSUInteger holidayDay;
@property (nonatomic, assign) NSUInteger holidayWeekday;
@property (nonatomic, assign) NSUInteger holidayOrdinalWeekday;

@property (nonatomic, assign) BOOL cancelledSave;

@end
