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
@class HolidaysViewController;

@interface AddHolidayViewController : BaseViewController <UITableViewDelegate , UITextFieldDelegate> {



}
@property (nonatomic, assign) BOOL newHoliday;
@property (nonatomic, retain) NSArray *tableList;
@property (nonatomic, retain) HolidaysViewController *holidaysViewController;
//@property (nonatomic, assign) NSUInteger holidayType;
//@property (nonatomic, assign) NSUInteger locationInList;
@property (nonatomic, retain) NSMutableDictionary *holiday;
@property (nonatomic, assign) BOOL saveHoliday;
@property (nonatomic, assign) BOOL changeMade;
//@property (nonatomic, retain) NSMutableArray *holidayList;
@property (nonatomic, retain) IBOutlet UITableView *holidayTypeTableView;
@property (nonatomic, retain) IBOutlet UITextField *holidayNameTextField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *holidayTypeSegmentControl;


- (void) cancelEdit;
- (IBAction) segmentAction:(id)sender;
- (IBAction) changeHolidayName;
- (IBAction)backgroundClick:(id)sender;
-(void)saveAndReturnToHolidayList;
-(BOOL)validateData;

@end
