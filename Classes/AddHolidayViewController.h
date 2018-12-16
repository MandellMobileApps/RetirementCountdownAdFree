//
//  AddHolidayViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectHolidayDateViewController.h"
#import "BaseViewController.h"

@class SelectHolidayDateViewController;

@interface AddHolidayViewController : BaseViewController <UITableViewDelegate , UITextFieldDelegate> {


NSArray *tableList;
NSUInteger holidayType;
NSUInteger locationInList;
NSMutableDictionary *holiday;
BOOL saveHoliday;
NSMutableArray *holidayList;
IBOutlet UITableView *holidayTypeTableView;
IBOutlet UITextField *holidayNameTextField;
IBOutlet UISegmentedControl *holidayTypeSegmentControl;


NSMutableString *holidayName;
int holidayMonth;
int holidayDay;
int holidayWeekday;
int holidayOrdinalWeekday;


}

@property (nonatomic, retain) NSArray *tableList;
@property (nonatomic, assign) NSUInteger holidayType;
@property (nonatomic, assign) NSUInteger locationInList;
@property (nonatomic, retain) NSMutableDictionary *holiday;
@property (nonatomic, assign) BOOL saveHoliday;
@property (nonatomic, retain) NSMutableArray *holidayList;
@property (nonatomic, retain) IBOutlet UITableView *holidayTypeTableView;
@property (nonatomic, retain) IBOutlet UITextField *holidayNameTextField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *holidayTypeSegmentControl;

@property (nonatomic, retain) NSMutableString *holidayName;
@property (nonatomic, assign) int holidayMonth;
@property (nonatomic, assign) int holidayDay;
@property (nonatomic, assign) int holidayWeekday;
@property (nonatomic, assign) int holidayOrdinalWeekday;


- (void) cancelEdit;
- (IBAction) segmentAction:(id)sender;
- (IBAction) changeHolidayName;
- (IBAction)backgroundClick:(id)sender;
-(void)saveAndReturnToHolidayList;
-(BOOL)validateData;

@end
