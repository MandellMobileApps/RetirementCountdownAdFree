//
//  Calendar.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/15/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//



#import "Calendar.h"
#import "ColorsClass.h"
#import "RootViewController.h"
#import "DayView.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation Calendar



- (id)initWithHandler:(RootViewController*)handler {
    

    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 300)]) {

		self.appDelegate = (RetirementCountdownAppDelegate*)[[UIApplication sharedApplication]delegate];
        self.rootViewController = handler;
        
		self.monthNames = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
		
		NSMutableArray *wdnLbls = [[NSMutableArray alloc] init];
		self.weekdaynameLabels = nil;
		self.weekdaynameLabels = wdnLbls;
		
        self.currentDisplayDayViews = [NSMutableArray array];


		// initialize and add weekday name labels
		[self reloadWeekdayNameLabels];
		
		// initialize and add day cells and corresponding buttons
        NSInteger d = 0;
        for(NSInteger i = 0; i < 6; i++)
        {
			for(NSInteger j = 0; j < 7; j++)
            {
				CGRect labelrect = CGRectMake(j * 44, (i * 38)+12, 45, 40);
                DayView* dayView = [DayView newDayViewWithRect:labelrect withHandler:self withRoot:self.rootViewController atIndex:d];

                [self addSubview:dayView];
                [self.currentDisplayDayViews addObject:dayView];
                d++;
			}
            
		}

    }
	
    self.todayYear = [GlobalMethods currentYear];
    self.todayMonth = [GlobalMethods currentMonth];
    self.todayDay = [GlobalMethods currentDay];
    self.currentYear = self.todayYear;
    self.currentMonth = self.todayMonth;

    return self;
}


-(void) reloadWeekdayNameLabels {
	// initialize and add weekday name labels
	NSArray *weekdaynames = [[NSArray alloc] initWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
	[self.weekdaynameLabels removeAllObjects];
	for(NSInteger i = 0; i < 7; i++) {
		UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(i * 44, 0, 45, 12)];
		lbl.text = [weekdaynames objectAtIndex:i];
		lbl.textAlignment = NSTextAlignmentCenter;
		lbl.font = [UIFont systemFontOfSize:12];
        lbl.backgroundColor = self.backgroundColor;
		[self.weekdaynameLabels addObject:lbl];

	}

	
	for(NSInteger i = 0; i < 7; i++) {
		[self addSubview:[self.weekdaynameLabels objectAtIndex:i]];
	}

}



// reset the view to default colors and empty day labels
- (void)reset {
	for(NSInteger i = 0; i < 42; i++) {
        DayView* thisDayView = [self.currentDisplayDayViews objectAtIndex:i];
       thisDayView.imageView.hidden = YES;
		thisDayView.lbl.backgroundColor = [UIColor clearColor];
		thisDayView.lbl.textColor = [UIColor blackColor];
		thisDayView.lbl.text = @"";

		[thisDayView.btn setBackgroundImage:[UIImage imageNamed:NotThisMonthPicture] forState:UIControlStateNormal];
		[thisDayView.btn setBackgroundImage:[UIImage imageNamed:NotThisMonthPicture] forState:UIControlStateHighlighted];
	}
}


-(void)drawCalendarToCurrentMonth {
    [self drawCalendarForYear:self.currentYear month:self.currentMonth];
}

- (void)gotoToday {
	//get todays NSDate at midnight
    self.todayYear = [GlobalMethods currentYear];
    self.todayMonth = [GlobalMethods currentMonth];
    self.todayDay = [GlobalMethods currentDay];
    self.currentYear = self.todayYear;
    self.currentMonth = self.todayMonth;
	[self drawCalendarForYear:self.todayYear month:self.todayMonth];
    

}

-(void)gotoRetirementDay {
    self.todayYear = self.appDelegate.settingsNew.retirementYear;
    self.todayMonth = self.appDelegate.settingsNew.retirementMonth;
    self.todayDay = self.appDelegate.settingsNew.retirementDay;
    self.currentYear = self.todayYear;
    self.currentMonth = self.todayMonth;
    [self drawCalendarForYear:self.todayYear month:self.todayMonth];

}




// draw the calendar for scrolling months  //////////////////////////////////////////////////////////////////////////////////////////
- (void)drawCalendarForYear:(NSInteger)year month:(NSInteger)month {
    NSString* day1String = [NSString stringWithFormat:@"%04ld%02ld01",(long)year,(long)month];
    NSString* day1sql = [NSString stringWithFormat:@"SELECT * FROM Days WHERE concat = %@",day1String];
    NSDictionary* day1Dict  = [SQLiteAccess selectOneRowWithSQL:day1sql];
   ;
    NSInteger day1weekday = [[day1Dict objectForKey:@"weekday"] integerValue];
    NSInteger day1id = [[day1Dict objectForKey:@"id"] integerValue];

    NSDateComponents* comps = [GlobalMethods currentYMDcomponts];
    self.todayYear = comps.year;
    self.todayMonth = comps.month;
    self.todayDay = comps.day;

    NSString *todayConcatString = [NSString stringWithFormat:@"%04ld%02ld%02ld",self.todayYear,self.todayMonth,self.todayDay];
    NSInteger todayConcat = [todayConcatString integerValue];

	// reset all days back to blank
	[self reset];
    
    // find number of days in given month
    NSInteger monthDays = [GlobalMethods daysinmonth:month year:year];

    // get Display height
    if (monthDays + day1weekday < 30) {
        self.totalweeks = 4;
        self.totaldays = 28;
    }
    else if (monthDays +day1weekday < 37)  {
        self.totalweeks = 5;
        self.totaldays = 35;
    } else {
        self.totalweeks = 6;
        self.totaldays = 42;
    }
                    //   test_expression < low_expression OR test_expression > high_expression
    
        NSInteger startId = day1id - day1weekday+1;
        NSInteger endId = startId + 42 -1;
    
        NSString* monthSql = [NSString stringWithFormat:@"SELECT * FROM Days WHERE id BETWEEN %li AND %li",startId,endId];
 
        NSArray* daysOfTheMonth = [SQLiteAccess selectManyRowsWithSQL:monthSql];

	//loop through DayViews  //////////////////////////////////////////////////////////////////

            // initialize and add day cells and corresponding buttons
        for(NSInteger i = 0; i < 42; i++) {
            NSDictionary* thisDateDict = [daysOfTheMonth objectAtIndex:i];
            Date* thisDate = [Date dateWithDictionary:thisDateDict];
            DayView* dayView =  [self.currentDisplayDayViews objectAtIndex:i];
 
            
            [dayView updateViewWithDay:thisDate forYear:self.currentYear forMonth:self.currentMonth withTodayConcat:todayConcat];
     

        }

}



- (void)previousMonth {
	if(self.currentMonth == 1) {
		self.currentYear--;
		self.currentMonth = 12;
	} else {
		self.currentMonth--;
	}	
	[self drawCalendarForYear:self.currentYear month:self.currentMonth];	
}


- (void)nextMonth {
	if(self.currentMonth == 12) {
		self.currentYear++;
		self.currentMonth = 1;
	} else {
		self.currentMonth++;
	}	
	[self drawCalendarForYear:self.currentYear month:self.currentMonth];	
}


- (void)previousYear {
	self.currentYear--;
	[self drawCalendarForYear:self.currentYear month:self.currentMonth];
}


- (void)nextYear {
	self.currentYear++;
	[self drawCalendarForYear:self.currentYear month:self.currentMonth];
}

- (NSString*)currentMonthName {
	return [self.monthNames objectAtIndex:self.currentMonth - 1];
}







@end

