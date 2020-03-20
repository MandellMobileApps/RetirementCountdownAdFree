//
//  TimeRemaining.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/7/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RetirementCountdownAppDelegate;


@interface TimeRemaining : NSObject {

}
//@property (nonatomic)  BOOL withTimeCalc;
@property (nonatomic,retain)  RetirementCountdownAppDelegate *appDelegate;
//@property (nonatomic, assign) BOOL addToday;
//@property (nonatomic,retain)  NSDate *today;

//@property (nonatomic)  NSInteger todayYear;
//@property (nonatomic)  NSInteger todayMonth;
//@property (nonatomic)  NSInteger todayDay;
//
//@property (nonatomic)  NSInteger retireYear;
//@property (nonatomic)  NSInteger retireMonth;
//@property (nonatomic)  NSInteger retireDay;
//
//@property (nonatomic)  NSInteger totalWorkdays;
//@property (nonatomic)  NSInteger secondsLeftToday;
//
//@property (nonatomic)  NSInteger calendarYearsLeft;
//@property (nonatomic)  NSInteger calendarMonthsLeft;
//@property (nonatomic)  NSInteger calendarDaysLeft;
//
//@property (nonatomic)  NSInteger calendarYearsLeftCount;
//@property (nonatomic)  NSInteger calendarMonthsLeftCount;
//@property (nonatomic)  NSInteger calendarDaysLeftCount;
//
//@property (nonatomic)  NSInteger lastYear;
//@property (nonatomic)  NSInteger lastMonth;
//@property (nonatomic)  NSInteger lastDay;
//
//@property (nonatomic)  NSInteger thisYear;
//@property (nonatomic)  NSInteger thisMonth;
//@property (nonatomic)  NSInteger thisDay;
//
//@property (nonatomic)  NSInteger totalAnnualDaysOff;
//@property (nonatomic,retain)  NSString *displayOption;
//@property (nonatomic,retain)  NSString *displayDaysLeft;

-(void)updateTimeRemaining;

@end
