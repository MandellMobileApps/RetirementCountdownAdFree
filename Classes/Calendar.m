//
//  Calendar.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/15/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//



#import "Calendar.h"
#import "ColorsClass.h"

@implementation Calendar

@synthesize appDelegate;
@synthesize weekdaynameLabels, labels, dayButtons, xImages;
@synthesize currentMonth, currentYear, day1weekday;
@synthesize  todayYear, todayMonth, todayDay, totaldays, totalweeks;
@synthesize thisIsToday, defaultdays, daysleft, absoluteTimeComponents, monthNames, buttonBackground, textColor;

- (void)dealloc {
	[appDelegate release];
	[weekdaynameLabels release];
	[labels release];
//	[labelCheckmarks release];
	[dayButtons release];
	[thisIsToday release];
	[defaultdays release];
	[absoluteTimeComponents release];
	[monthNames release];
	[buttonBackground release];
	[textColor release];
    [xImages release];
	[super dealloc];
}




- (id)initWithHandler:(id)handler {
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 300)]) {
	
		self.appDelegate = (RetirementCountdownAppDelegate*)[[UIApplication sharedApplication]delegate];
	
		self.monthNames = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
		
		NSMutableArray *wdnLbls = [[NSMutableArray alloc] init];
		self.weekdaynameLabels = nil;
		self.weekdaynameLabels = wdnLbls;
		[wdnLbls release];
		
		NSMutableArray *ca = [[NSMutableArray alloc] init];
		self.labels = nil;
		self.labels = ca;
		[ca release];

//		NSMutableArray *cm = [[NSMutableArray alloc] init];
//		self.labelCheckmarks = nil;
//		self.labelCheckmarks = cm;
//		[cm release];
		
		NSMutableArray *cba = [[NSMutableArray alloc] init];
		self.dayButtons = nil;
		self.dayButtons = cba;
		[cba release];

		NSMutableArray *xi = [[NSMutableArray alloc] init];
		self.xImages = nil;
		self.xImages = xi;
		[xi release];

		// initialize and add weekday name labels
		[self reloadWeekdayNameLabels];
		
		// initialize and add day cells and corresponding buttons
        for(int i = 0; i < 6; i++) {
			for(int j = 0; j < 7; j++) {
			
				CGRect labelrect = CGRectMake(j * 44, (i * 38)+12, 45, 40);  

				UILabel *lbl = [[UILabel alloc] initWithFrame:labelrect];
				lbl.textAlignment = UITextAlignmentCenter;
				lbl.font = [UIFont systemFontOfSize:24];
				[self.labels addObject:lbl];
				[lbl release];
				
//				UILabel *lblm = [[UILabel alloc] initWithFrame:labelrect];
//				lblm.textAlignment = UITextAlignmentCenter;
//				lblm.font = [UIFont systemFontOfSize:44];
//				lblm.textColor = [UIColor redColor]; 
//				lblm.backgroundColor = [UIColor clearColor];
//				[self.labelCheckmarks addObject:lblm];
//				[lblm release];
				
				UIButton *btn = [[UIButton alloc] initWithFrame:labelrect];
				[btn addTarget:handler action:@selector(dayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
				[self.dayButtons addObject:btn];
				[btn release];
                
				UIImageView *xImageView = [[UIImageView alloc] initWithFrame:labelrect];
                xImageView.backgroundColor = [UIColor clearColor];
                xImageView.alpha = 0.65;
                xImageView.image = [UIImage imageNamed:@"red-x-outer.png"];
                [self.xImages addObject:xImageView];
				[xImageView release];
			}
		}

		NSDate *today = [NSDate date];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:today];
		self.todayYear = [comps year];
		self.todayMonth = [comps month];
		self.todayDay = [comps day];
		self.thisIsToday = [gregorian dateFromComponents:comps];
		self.currentYear = self.todayYear;
		self.currentMonth = self.todayMonth;
		[gregorian release];
    }
	
//	NSLog(@"[[initial self subviews] count] %i",[[self subviews] count]);
	[self gotoToday];

    return self;
}


-(void) reloadWeekdayNameLabels {

	// initialize and add weekday name labels
	NSArray *weekdaynames = [[NSArray alloc] initWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
	[self.weekdaynameLabels removeAllObjects];
	for(int i = 0; i < 7; i++) {
		UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(i * 44, 0, 45, 12)];
		lbl.text = [weekdaynames objectAtIndex:i];
		lbl.textAlignment = UITextAlignmentCenter;
		lbl.font = [UIFont systemFontOfSize:12];
		lbl.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
		[self.weekdaynameLabels addObject:lbl];
		[lbl release];
	}
	[weekdaynames release];
	
	for(int i = 0; i < 7; i++) {
		[self addSubview:[self.weekdaynameLabels objectAtIndex:i]];
	}

}



// reset the view to default colors and empty day labels
- (void)reset {
	for(int i = 0; i < 42; i++) {
		UILabel *lbl = [self.labels objectAtIndex:i];
//		UILabel *lblc = [self.labelCheckmarks objectAtIndex:i];
		UIButton *btn = [self.dayButtons objectAtIndex:i];
        UIImageView *xImageView = [self.xImages objectAtIndex:i];
        xImageView.hidden = YES;
		lbl.backgroundColor = [UIColor clearColor]; 
		lbl.textColor = [UIColor blackColor];
//		lblc.textColor = [UIColor redColor]; 
//		lblc.backgroundColor = [UIColor clearColor];
//		lblc.shadowColor = [UIColor blackColor];
//		CGSize offsetsize = CGSizeMake(2.0,2.0);
//		lblc.shadowOffset = offsetsize;
//		lblc.text = @"";
		lbl.text = @"";
		[btn setBackgroundImage:[self.appDelegate imageFromCache:NotThisMonthPicture] forState:UIControlStateNormal];
		[btn setBackgroundImage:[self.appDelegate imageFromCache:NotThisMonthPicture] forState:UIControlStateHighlighted];
	}
}

- (void)gotoToday {
	//get todays NSDate at midnight
	NSDate *today = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:today];
	self.currentYear = [comps year];
	self.currentMonth = [comps month];
	[self drawCalendarForYear:self.todayYear month:self.todayMonth];	
	[gregorian release];
}

-(void)gotoRetirementDay {
	NSDate *retirementDate  = [self.appDelegate.settings objectForKey:@"RetirementDate"];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:retirementDate];
	int year = [comps year];
	int month = [comps month];
	[self drawCalendarForYear:year month:month];	
	[gregorian release];
}


-(void)drawCalendarToCurrentMonth {
	[self drawCalendarForYear:currentYear month:currentMonth];
}


// draw the calendar for scrolling months  //////////////////////////////////////////////////////////////////////////////////////////
- (void)drawCalendarForYear:(NSInteger)year month:(NSInteger)month {
	//NSLog(@"here");

	// reset all days back to blank
	[self reset];

	// find number of days in given month
	NSInteger daysinmonth = [self getdaysinmonth:month year:year];

	// get the first day of the month
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *firstofmonthcomps1 = [[NSDateComponents alloc] init];
	[firstofmonthcomps1 setDay:1];
	[firstofmonthcomps1 setMonth:month];
	[firstofmonthcomps1 setYear:year];
	NSDate *firstofmonthdate = [gregorian dateFromComponents:firstofmonthcomps1];
	NSDateComponents *firstofmonthcomps2 = [gregorian components:NSWeekdayCalendarUnit fromDate:firstofmonthdate];
	self.day1weekday = [firstofmonthcomps2 weekday];
	[firstofmonthcomps1 release];
	[gregorian release];


	// assign day values to cells calculated with an offset of first weekday of month
	if (daysinmonth + self.day1weekday < 30) {
		self.totalweeks = 4;
		self.totaldays = 28;
	}
	else if (daysinmonth + self.day1weekday < 37)  {
		self.totalweeks = 5;
		self.totaldays = 35;
	} else {
		self.totalweeks = 6;
		self.totaldays = 42;
	}
	

//NSLog(@"Before [[self subviews] count] %i",[[self subviews] count]);	
	///// add all the labels and buttons to view
	for(int i = 0; i < self.totaldays; i++) {
		[self addSubview:[self.dayButtons objectAtIndex:i]];
		[self addSubview:[self.labels objectAtIndex:i]];
        [self addSubview:[self.xImages objectAtIndex:i]];
//		[self addSubview:[self.labelCheckmarks objectAtIndex:i]];
	}
	//NSLog(@"here 6 ");
//NSLog(@"After [[self subviews] count] %i",[[self subviews] count]);
	//  get first day of calendar page
	NSInteger amount = 1-self.day1weekday;
	NSDate *startdate = [self dateincrement:firstofmonthdate daystostep:amount monthstostep:0];
	NSDate *currentdate = startdate;

	
	//loop through days  //////////////////////////////////////////////////////////////////
	for(int i = 0; i < self.totaldays; i++) {
		// get currrent date components
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *currentdaycomps = [gregorian components:(NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:currentdate];
		int currentday = [currentdaycomps day];
		int currentmonth = [currentdaycomps month];	
		[gregorian release];
		
		//get day objects for current day
		UILabel *daylabel = [self.labels objectAtIndex:i];
//		UILabel *checkmarklabel = [self.labelCheckmarks objectAtIndex:i];
		UIButton *daybutton = [self.dayButtons objectAtIndex:i];
        UIImageView *xImageView = [self.xImages objectAtIndex:i];
		//UIImage *buttonBackground;

		// set tag on buttons to current day (for identifying during tapping)
		if (currentmonth == month) {
			daybutton.tag = currentday;
			[self getDayColorsFor:currentdate];
			daylabel.textColor  = self.textColor;
		}else {
			daybutton.tag = -1;
			self.buttonBackground = [self.appDelegate imageFromCache:NotThisMonthPicture];
			daylabel.textColor = [UIColor grayColor];
		}
	
//		if (currentmonth == month) {
//			[self getDayColorsFor:currentdate];
//			daylabel.textColor  = self.textColor;
//		} else {   //@"Not this month";
//			self.buttonBackground = [self.appDelegate imageFromCache:NotThisMonthPicture];
//			daylabel.textColor = [UIColor grayColor];
//		}
		
		[daybutton setBackgroundImage:self.buttonBackground forState:UIControlStateNormal];
		[daybutton setBackgroundImage:self.buttonBackground forState:UIControlStateHighlighted];
		
		// add date to cell		
		NSString *daylabeltext = [[NSString alloc] initWithFormat:@"%i", currentday];
		daylabel.text = daylabeltext;
		[daylabeltext release];

		// is current day before today?  if so, put checkmark on it.
		if ([self.thisIsToday compare:currentdate] == NSOrderedDescending) {  
//			unichar	character = 0x2573;
//			NSString *checkmark = [NSString stringWithCharacters:&character length:1];
//			checkmarklabel.text = checkmark;
			xImageView.hidden = NO;
		}
        else
        {
            xImageView.hidden = YES;
        }

		// increment to the next day of the month
		currentdate = [self dateincrement:currentdate daystostep:1 monthstostep:0];
		
	}  // end of looping through days
		
	self.currentYear = year;  // set instance variable to current year
	self.currentMonth = month; // set instance variable to current month
	//NSLog(@"here 9");
}



-(NSInteger)getdaysinmonth:(NSInteger)month year:(NSInteger)year {
	NSInteger dim;
	dim = 0;
	switch(month) {
		case 1:		// January
			dim = 31;
			break;
		case 2:		// February (check if leap-year)
			dim = ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) ? 29 : 28;
			break;
		case 3:		// March
			dim = 31;
			break;
		case 4:		// April
			dim = 30;
			break;
		case 5:		// May
			dim = 31;
			break;
		case 6:		// June
			dim = 30;
			break;
		case 7:		// July
			dim = 31;
			break;
		case 8:		// August
			dim = 31;
			break;
		case 9:		// September
			dim = 30;
			break;
		case 10:	// October
			dim = 31;
			break;
		case 11:	// November
			dim = 30;
			break;
		case 12:	// December
			dim = 31;
			break;
	}
	return dim;
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


- (void)updateSelectionDoubleTap:(id)sender {
	NSDate *thedateselected = [self getdatefromcomps:self.currentMonth day:[sender tag] year:self.currentYear];
	int index = 0;
	int index2 = 0;
	for (id workday in self.appDelegate.manualworkdays) {
		index++;
		if ([(NSDate*)[workday objectAtIndex:0] compare:thedateselected] == NSOrderedSame) {
				index2 = index;
		}
		
	}
		if (index2 > 0) {
		[self.appDelegate.manualworkdays removeObjectAtIndex:index2-1];
		}
		
		//set manual workdays in DataEngine

		[self drawCalendarForYear:self.currentYear month:self.currentMonth];		
}


- (void)updateSelection:(id)sender {
	NSDate *thedateselected = [self getdatefromcomps:self.currentMonth day:[sender tag] year:self.currentYear];
//NSLog(@"here");
		int indb = 0;
	NSString *stateofday;

	int w = 0;	
	//NSLog(@"here 1 ");
		for (id workday in self.appDelegate.manualworkdays) {
	//	NSLog(@"here 2 ");
			if ([(NSDate*)[workday objectAtIndex:0] isEqualToDate:thedateselected]) {
				indb = 1;
				if ([[workday objectAtIndex:1] isEqualToString:@"YES"]) {
					[[self.appDelegate.manualworkdays objectAtIndex:w] replaceObjectAtIndex:1  withObject:@"NO"];
					stateofday = @"NO";
				} else {
					[[self.appDelegate.manualworkdays objectAtIndex:w] replaceObjectAtIndex:1  withObject:@"YES"];
					stateofday = @"YES";
				}
			}
			w++;
		}
	//NSLog(@"here 3 ");

	//add to manual if not already on manual list	
		if (indb==0) {
			// get current status (is it currently a workday?)
			stateofday = [GlobalMethods isDefaultDayWorkday:thedateselected forWorkdays:self.appDelegate.workdays forHolidays:self.appDelegate.holidaylist];
			NSLog(@"stateofday %@",stateofday);

			if ([stateofday isEqualToString:@"YES"]) {
				stateofday = @"NO";
			}else{
				stateofday = @"YES";
			}
			NSMutableArray *objectarray = [[NSMutableArray alloc ] initWithObjects:thedateselected,stateofday,nil];
			[self.appDelegate.manualworkdays addObject:objectarray];
			[objectarray release];

		}


	if ([stateofday isEqualToString:@"YES"]) {  // workday
		[[self.dayButtons objectAtIndex:[sender tag] + self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:5]] forState:UIControlStateNormal];
		[[self.dayButtons objectAtIndex:[sender tag]+ self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:5]] forState:UIControlStateHighlighted];
		[[self.labels objectAtIndex:[sender tag]+ self.day1weekday - 2] setTextColor:[ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:5])]];
	} else {
		[[self.dayButtons objectAtIndex:[sender tag]+ self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:6]] forState:UIControlStateNormal];
		[[self.dayButtons objectAtIndex:[sender tag]+ self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:6]] forState:UIControlStateHighlighted];
		[[self.labels objectAtIndex:[sender tag]+ self.day1weekday - 2] setTextColor:[ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:6])]];
	}	
	

}

- (NSString*)currentMonthName {
	return [self.monthNames objectAtIndex:self.currentMonth - 1];
}

-(NSDate*) dateincrement:(NSDate*)date daystostep:(NSInteger)daystoStep monthstostep:(NSInteger)monthstoStep {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
		[offsetComponents  setDay:daystoStep];	
		[offsetComponents  setMonth:monthstoStep];
	NSDate *newdate = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];// autorelease];
	[gregorian release];
	[offsetComponents release];
	return newdate;
}

-(NSDate *)getfirstdayofmonth:(NSDate *)date {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *todaycomps = [gregorian components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
	[todaycomps setDay:1];
	NSDate *todayfirstofmonthdate= [gregorian dateFromComponents:todaycomps];
	[gregorian release];	
	return todayfirstofmonthdate;
}

-(NSDate *)getdatefromcomps:(NSInteger)month day:(NSInteger)day year:(NSInteger)year {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setDay:day];
	[comps setMonth:month];
	[comps setYear:year];
	NSDate *date = [gregorian dateFromComponents:comps];
	[comps release];
	[gregorian release];
	return date;

}


#pragma mark -
#pragma mark Day Methods

-(void)getDayColorsFor:(NSDate*)date {
	
	NSString *workdayStatus = [GlobalMethods isWorkday:date forWorkdays:self.appDelegate.workdays];	
	NSString *holidayStatus = [GlobalMethods isHoliday:date forHolidays:self.appDelegate.holidaylist];
	NSString *manualWorkdayStatus = [GlobalMethods isManualWorkday:date forManualWorkdays:self.appDelegate.manualworkdays];
	//NSLog(@"date %@",date);


	if ([workdayStatus isEqualToString:@"YES"]) { //@"Workday";
		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:2]];
		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:2])];
	}else {  //@"NonWorkday";
		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:3]];
		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:3])];
	}
	
	
	if (![holidayStatus isEqualToString:@"NO"]) {
		NSArray *tempHolidays = [[NSArray alloc] initWithObjects:@"USA Independance Day",@"Thanksgiving Day",@"Christmas",nil];
		for (NSString *holiday in tempHolidays) {
			if ([holidayStatus isEqualToString:holiday]) {
				if ([holiday isEqualToString:@"USA Independance Day"]) {
					self.buttonBackground = [self.appDelegate imageFromCache:holidayStatus];
					self.textColor = [UIColor whiteColor];
				} else if ([holiday isEqualToString:@"Thanksgiving Day"]) {
					self.buttonBackground = [self.appDelegate imageFromCache:holidayStatus];
					self.textColor = [UIColor whiteColor];				
				} else if ([holiday isEqualToString:@"Christmas"]) {
					self.buttonBackground = [self.appDelegate imageFromCache:holidayStatus];
					self.textColor = [UIColor blackColor];
				}
			} else {
				self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:4]];
				self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:4])];
			}
			
		}
		[tempHolidays release];
		
		
	}	
	//NSLog(@"here 7");
	
	if ([[GlobalMethods getToday] compare:date] == NSOrderedSame) {  	//@"Today";
		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:0]];
		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:0])];
	}

	if ([[GlobalMethods getThisDateAtMidnight:[self.appDelegate.settings objectForKey:@"RetirementDate"]] compare:date] == NSOrderedSame) {  //@"Retirement Day";
		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:1]];
		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:1])];
	}
	
	if ([manualWorkdayStatus isEqualToString:@"ManualYES"]) {
		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:5]];
		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:5])];
		
	}else if ([manualWorkdayStatus isEqualToString:@"ManualNO"]){
		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:6]];
		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:6])];
	}
	
//NSLog(@"here 8");
}




@end

