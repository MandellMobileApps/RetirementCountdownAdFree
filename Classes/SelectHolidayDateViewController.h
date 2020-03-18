//
//  SelectHolidayDateViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/16/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@class AddHolidayViewController;

@interface SelectHolidayDateViewController : BaseTableViewController {



}

//@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) AddHolidayViewController *addHolidayViewController;
@property (nonatomic, retain) NSMutableDictionary *holiday;
@property (nonatomic, retain) NSString *tableToLookup;
@property (nonatomic, assign) NSUInteger valueSelected;
@property (nonatomic, assign) NSUInteger locationInList;


@property (nonatomic, assign) BOOL cancelledSave;

@end
