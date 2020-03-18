//
//  temp.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/15/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetirementCountdownAppDelegate.h"

#define NotThisMonthPicture @"GlossAluminum.png"

@class RootViewController;

@interface Calendar : UIView {

	


}

@property (nonatomic, retain	) RetirementCountdownAppDelegate *appDelegate;
@property (nonatomic, retain    ) RootViewController *rootViewController;
@property (nonatomic, retain	) NSMutableArray	*weekdaynameLabels;

@property (nonatomic, retain    ) NSMutableArray    *currentDisplayDayViews;

@property (nonatomic, assign	) NSInteger			currentYear;
@property (nonatomic, assign	) NSInteger			currentMonth;
@property (nonatomic, assign	) NSInteger			todayYear;
@property (nonatomic, assign	) NSInteger			todayMonth;
@property (nonatomic, assign	) NSInteger			todayDay;
@property (nonatomic, assign	) NSInteger			day1weekday;
@property (nonatomic, assign	) NSInteger			totaldays;
@property (nonatomic, assign	) NSInteger			totalweeks;

@property (nonatomic, assign	) NSInteger			daysleft;
@property (nonatomic, retain	) NSArray			*monthNames;


@property (nonatomic, assign) NSUInteger tapCount;

- (id)initWithHandler:(id)handler;
- (void)reset;
-(void) reloadWeekdayNameLabels;

- (void)drawCalendarForYear:(NSInteger)year month:(NSInteger)month;
-(void)drawCalendarToCurrentMonth;

- (void)previousMonth;
- (void)nextMonth;
- (void)previousYear;
- (void)nextYear;



- (NSString*)currentMonthName;

-(NSInteger)getdaysinmonth:(NSInteger)month year:(NSInteger)year;


-(NSDate *)getdatefromcomps:(NSInteger)month day:(NSInteger)day year:(NSInteger)year;
-(void)gotoRetirementDay;
- (void)gotoToday;

-(void)getDayColorsFor:(NSDate*)date;

//- (void)updateSelection:(id)sender;
//- (void)updateSelectionDoubleTap:(id)sender;
//- (void)daySelectedDoubleTap:(id)sender;
//- (void)daySelectedSingleTap:(id)sender;
//-(void)resetTapCount:(id)sender;
//- (void)dayButtonTapped:(id)sender;
//
//- (void)updateSelectionDoubleTapFor:(UIView*)thisBtnView;
//- (void)daySelectedSingleTapFor:(UIButton*)thisBtn;

@end
