//
//  temp.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/15/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetirementCountdownAppDelegate.h"

#define NotThisMonthPicture @"GlossAluminum"


@interface Calendar : UIView {

	RetirementCountdownAppDelegate *appDelegate;

	NSMutableArray *weekdaynameLabels;		// arrays of weekday name labels
	NSMutableArray *labels;			// array of day labels
//	NSMutableArray *labelCheckmarks;  // array of checkmark labels
	NSMutableArray *dayButtons;		// array of day buttons for user interaction
    NSMutableArray *xImages;		// array of day imageViews for user interaction

	id				_handler;		// handler that acts as event day data source and user interactions

	NSInteger		currentYear;	// currently displayed year
	NSInteger		currentMonth;	// currently displayed month
    NSInteger       day1weekday;
//	int				day1weekday;	// weekday index of the first day of currently displayed month  Sunday = 1

	NSInteger		todayYear;	 
	NSInteger		todayMonth;	 
	NSInteger		todayDay;	 	
	NSInteger		totalweeks;	 	
	NSInteger		totaldays;
	NSDate			*thisIsToday;
	NSMutableArray	*defaultdays;
	NSInteger		_selectedCell;
	NSInteger		daysleft;
	NSArray			*monthNames;
	UIImage			*buttonBackground;
	UIColor			*textColor;
	NSDateComponents *absoluteTimeComponents;
}

@property (nonatomic, retain	) RetirementCountdownAppDelegate *appDelegate;
@property (nonatomic, retain	) NSMutableArray	*weekdaynameLabels;
@property (nonatomic, retain	) NSMutableArray	*labels;
//@property (nonatomic, retain	) NSMutableArray	*labelCheckmarks;
@property (nonatomic, retain	) NSMutableArray	*dayButtons;
@property (nonatomic, retain	) NSMutableArray	*xImages;
@property (nonatomic, retain	) NSDate			*thisIsToday;
@property (nonatomic, assign	) NSInteger			currentYear;
@property (nonatomic, assign	) NSInteger			currentMonth;
@property (nonatomic, assign	) NSInteger			todayYear;
@property (nonatomic, assign	) NSInteger			todayMonth;
@property (nonatomic, assign	) NSInteger			todayDay;
@property (nonatomic, assign	) NSInteger			day1weekday;
@property (nonatomic, assign	) NSInteger			totaldays;
@property (nonatomic, assign	) NSInteger			totalweeks;
@property (nonatomic, retain	) NSMutableArray	*defaultdays;
@property (nonatomic, assign	) NSInteger			daysleft;
@property (nonatomic, retain	) NSDateComponents *absoluteTimeComponents;
@property (nonatomic, retain	) NSArray			*monthNames;
@property (nonatomic, retain	) UIImage			*buttonBackground;
@property (nonatomic, retain	) UIColor			*textColor;
	
- (id)initWithHandler:(id)handler;
- (void)reset;
-(void) reloadWeekdayNameLabels;

- (void)drawCalendarForYear:(NSInteger)year month:(NSInteger)month;
-(void)drawCalendarToCurrentMonth;

- (void)previousMonth;
- (void)nextMonth;
- (void)previousYear;
- (void)nextYear;

- (void)updateSelection:(id)sender;
- (void)updateSelectionDoubleTap:(id)sender;

- (NSString*)currentMonthName;

-(NSDate*) dateincrement:(NSDate*)date daystostep:(NSInteger)daystoStep monthstostep:(NSInteger)monthstoStep;
-(NSInteger)getdaysinmonth:(NSInteger)month year:(NSInteger)year;
-(NSDate *)getfirstdayofmonth:(NSDate *)date;

-(NSDate *)getdatefromcomps:(NSInteger)month day:(NSInteger)day year:(NSInteger)year;
-(void)gotoRetirementDay;
- (void)gotoToday;

-(void)getDayColorsFor:(NSDate*)date;





@end
